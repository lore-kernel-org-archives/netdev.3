Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F2248F64
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549285; cv=none; b=mig4qNtnJRtSHeUXk59bRXHwt28WNGpqhncQBFIQCIH7JSVrm1d27lkooHY27FeBugT6wW9AcnFd/ExFwyJLkSIOe9YC9t5NLBCwSfy3A/cDUSSlJqbkpWtDazBWd6tK8f4H8xRFlLQ0Yqo9LC52ZhUeQ2hAojUUOQPU7pyDxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549285; c=relaxed/simple;
	bh=EXkg6E3ql7iRNmgARh0B4/skP6yEs+ajHYM7VvGebkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjs21/1uqx8WX95PUTzZz7A7z92HAD2oz3ElQ3i9CnBULJrmgLmxlLlxw4P8azvukt5W4fzGc1yfju3ZecpF0aOwNFVfBMrGrtfwaBYykqWLdpepTMlrUNcwL4nDjZucakVoSLtxvFsqN90rqFUtgkxTbvWHX+1DcmIWvWKPaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmnVwFEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmnVwFEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E3A1F00A3F;
	Fri,  4 Sep 2026 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549279;
	bh=CLaiAQyVXkEUeLrjPv6X/u5tFBvLAxlTZsoD1WIyTdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CmnVwFEW9SnQAmzFkiGtR1r+HyN6aGcvJOop0/FunKNUnts9eUZmZO4YDEg9VdwPC
	 NcU6FT3KWtMDMhqLRBIwMNzvRtzeBKlK5kBG1Vfig0Iob1tGFvF2/VWkHO3exwclan
	 NiFAk271RSn144GfxjQy5+5N0YBttqpRP2It27yROQrFj9I08NpWye7TEfV9mnK8Wg
	 LgTlpfn+O/uIEaveyznywe32I369zXYTxe7zvUm8VvZhGpYiwGO0r4dtBcvcFsF5KM
	 5BSGWgEEN4Ufyx10lUxTBQptk0IAyiWD1QUBmATR4cFOo2/+8y26/HaodNJAo9j4/e
	 fHVHx+F7zhGug==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] netlink: specs: fou: link the type attribute to the encap-type enum
Date: Fri,  4 Sep 2026 12:14:12 -0700
Message-ID: <20260904191412.3872344-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904191412.3872344-1-kuba@kernel.org>
References: <20260904191412.3872344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spec defines encap-type (unspec / direct / gue), but no attribute
references it, so the definition exists only to emit FOU_ENCAP_* into
the uAPI header - while FOU_ATTR_TYPE is exactly that value space:
fou_create() switches on FOU_ENCAP_DIRECT / FOU_ENCAP_GUE and returns
-EINVAL for anything else. Python YNL could not accept or display the
names and the generated C exposed a raw __u8 setter.

The global policy entry becomes NLA_POLICY_MAX(NLA_U8, 2). For add
that only moves the existing fou_create() rejection earlier; del and
get ignore FOU_ATTR_TYPE altogether, so a bogus type there now fails
validation instead of being dropped on the floor.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/fou.yaml | 1 +
 net/ipv4/fou_nl.c                    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 1d0db6ba7e52..3e6a38e31202 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -44,6 +44,7 @@ kernel-policy: global
       -
         name: type
         type: u8
+        enum: encap-type
       -
         name: remcsum-nopartial
         type: flag
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index cdb174b92cdd..ccd134ba352d 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -16,7 +16,7 @@ const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_AF] = { .type = NLA_U8, },
 	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),
-	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
+	[FOU_ATTR_TYPE] = NLA_POLICY_MAX(NLA_U8, 2),
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_BE32, },
 	[FOU_ATTR_LOCAL_V6] = NLA_POLICY_EXACT_LEN(16),
-- 
2.55.0

