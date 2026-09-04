Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0751C331;
	Fri,  4 Sep 2026 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548664; cv=none; b=QzsOZQs8APfqtTgYEi9/QmZ9d1DDhwEu30gIhH+9G7uRvg4dM0FcmPauKFPtXvdwsZLpHfWELVifvCfZ9OYqUmfzKqghXK8C/pN6klu6JuXT50uHydew8GxlfhBVY8UbOL8prMe4SaSfH7ytzRVQcPJmrKO9ZZ1Dbs7tzDz2bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548664; c=relaxed/simple;
	bh=dP3fQcGxzvOrMadRQONEXJqvM92uBOB3B/+Zm6M/XpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGWuEDaKnSXxRJ8y2gfHuWB8F/B3OgLs0TEwmJqwXFA0NMg4DzFZP26IkIGNnG3mx48zUYISMr36yrvSBhWrLoaV25PwWhMyHL4qzFLcsXlSEAPe6NLcrrwQeiD3hOKcpsGLgIWBH2elgpbgBXQoemi2JVq0ATbix250M+0iryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2EICtN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2EICtN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357B01F00A3D;
	Fri,  4 Sep 2026 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788548653;
	bh=sv2BgnYTy8HRx12ABclt/pv89smzYxEs5NWqHssn4B8=;
	h=From:To:Cc:Subject:Date;
	b=I2EICtN+XazmgsjxkZBx7vQ65ARq+v7pzjnvOpmcisEOWclNsYmTRo5yTqGKflf9u
	 3GBzzv0X/Cy7DFanr5eSoxKFCtuaI3+QrMpzsWotYvBjhi08qYEH+840MtuLlkE4+9
	 X02TuuicCWt4+YW/Ld//Xw/CRpf3thgzgPM4Nj0QJKqo0d0mXcLVuAvcRpmozNQK7e
	 2hk16qi1k9nb+o2W6dRZqztWoLsGrjLpZa6I3/zPQTnbyQKIGIeTTGQc3HHHN67nfo
	 MzzDSaCJ0jVH7L8pR1meh9j4qQWyag/pRPYsg1uCYC8ueqE0CJDPSukx/0J06lm8kG
	 2iXG7T8IXnl6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	cel@kernel.org,
	donald.hunter@gmail.com,
	kernel-tls-handshake@lists.linux.dev
Subject: [PATCH net-next 1/2] netlink: specs: handshake: type the remaining key serials s32
Date: Fri,  4 Sep 2026 12:04:09 -0700
Message-ID: <20260904190410.3864660-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

include/linux/key.h has "typedef int32_t key_serial_t" and commit
160f404495aa ("handshake: Fix sign of key_serial_t fields") converted
x509.cert and x509.privkey to s32, but accept.peer-identity,
accept.keyring and done.remote-auth were left as u32 - the same
quantity typed both ways inside one family, and a generated user space
struct with __s32 cert next to __u32 keyring. All three come from
key_serial_t storage in net/handshake/tlshd.c (treq->th_peerid[],
treq->th_keyring), and special keyrings are legitimately negative
(KEY_SPEC_PROCESS_KEYRING is -2).

NLA_U32 and NLA_S32 have the same length and no range check here, so
the only wire effect is how the value is printed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: cel@kernel.org
CC: donald.hunter@gmail.com
CC: kernel-tls-handshake@lists.linux.dev
---
 Documentation/netlink/specs/handshake.yaml | 6 +++---
 net/handshake/genl.c                       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index ffec12b46759..9ab46da04c49 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -67,7 +67,7 @@ doc: Netlink protocol to request a transport layer security handshake.
         enum: auth
       -
         name: peer-identity
-        type: u32
+        type: s32
         multi-attr: true
       -
         name: certificate
@@ -79,7 +79,7 @@ doc: Netlink protocol to request a transport layer security handshake.
         type: string
       -
         name: keyring
-        type: u32
+        type: s32
   -
     name: done
     attributes:
@@ -93,7 +93,7 @@ doc: Netlink protocol to request a transport layer security handshake.
         type: s32
       -
         name: remote-auth
-        type: u32
+        type: s32
         multi-attr: true
 
 operations:
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index feac1ad063ee..58606c2a4600 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -21,7 +21,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
-	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_S32, },
 };
 
 /* Ops table for handshake */
-- 
2.55.0

