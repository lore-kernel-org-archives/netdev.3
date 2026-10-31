Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793425609;
	b=GpEH/5jdu2XbAGCfrQlAa1rag0sFO8UF/EU3EK2LCM4G21gwr8bq+5Oz05NbYV/iTf/D
	 +f4gprk3sQS2T0tpqCssscIy6H6Ihbn+TzTC2bAI3EsMIkxthvwC8j2Mn/Am4fK181E3E
	 lg/MPNvtY6nZbDMbs9O7DGP+NN8xe5BjBkUWZKxAmQ/H0h7Rq6nKZF/U/R4ce+e0cYwTZ
	 FQ1cwM3ZYQ44Bjz16pGSTztnWmZyH1ZDR8AQ+QNZeMsxRqk/U9KNgfS2oJbnVUD99kRgY
	 8aqNF3+kihKJywV+3wRKGxNT6JsqkDZtrDdw947g9zf0Ccxsfn21LaqTi/FgbI7YpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793425609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UW3BQ/Y5PiheRrkEpcONiNTmtPHiTfQrc+Cn+a3/JAE=;
	b=RxxdoHXbbFyA4YgIAELG6rN1iYOo1UEFWMnLUohoY7cN6cdMwinR4Egd21Uj9LPxEcV9
	 +MhVzL78ZvH87qMO5H4B1s6UlaF7IjTsNE4W9jXUiE+V0Nxd0Dm4GhG9tVnRTehEz/9AV
	 Lt5PgHoXYvpGX4ycqIAfEtJjTuYoOG7kjD+7i3WgHJgg+7Ci40PtxJbnnZjbbRxvzugHt
	 qdBuZbDMygI/ySY9Rsgt7nlkcRlhydc9a+Gy22V3ayGXI4TocAAC8uNuVM+BOTsWnwAeT
	 m4UUAGbFHzRMvwQN4DKtY4Kw4naebysNYq1rwmyGQY/NEYpp02cEpEfRi5yN7NlPC5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5oaTt9Q;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809E606A31E
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 05:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6809E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5oaTt9Q
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso2238615eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793425608; x=1794030408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UW3BQ/Y5PiheRrkEpcONiNTmtPHiTfQrc+Cn+a3/JAE=;
        b=O5oaTt9Q4TqZOVrT2B9SV76ivfBonsnDWXbr8gc+d75/IBvHLUOr2ZCt9Z4mzI/J9i
         vR9reN6cLhhyx679o4IwXW9GMGC4LI1Bd5oyVh6Ttq3umuBSLzOhzxZEn0ybaHQQ7SlE
         B1X/6LKEDA5UK+HRO9TliPtsajk/+17mVJycrHt26tyuL2pExAFVsIdJAO3tS8BLiKjd
         BdnU6ATNqcyBAtoEM9FY5kKib9NfWpZ6vkwtUer/d9eMRFsWYW9voLYfG9frPly0UMz0
         PKVCoHLIs0sp7WaPe7jMUSMIxsjSH4hhm8i34ExT20pvmwaEo1/QCRU3geYkw9nLeIPf
         LnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793425608; x=1794030408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UW3BQ/Y5PiheRrkEpcONiNTmtPHiTfQrc+Cn+a3/JAE=;
        b=0Sdau8zOhLnDKUvQY6ezDQhHi7SQuNLXnw8j8541hVfl3TScb5ViAlBTYr7udgtj2V
         +YRbAQUjmmaT09Oug/xMoD+lAEg5buDSwYGZzmKBb+XNeRUo8nlofqYIBZjWs8utI+Ar
         E99FXp7PXcfqL6g3S83DoKCpCArDINQONTjjq6gImMzG8E2N0YT2rY9aapJGa7/Ls0zG
         P618HYM81FyfedViaWINuSD4EB7Hx3pFf8hFxC44fZcDz+OpSKVApssh9x3MrCoYiXKL
         9mm44NcyvOvFfTV5mmlz6zAHtozAI6AjTCt2lYT+Tc33ZnaCdC0abJXvhYbTK/u6Ln09
         1Ltw==
X-Gm-Message-State: AFq9FYJwsJmSp+JoguddXa7aIiD87m3J4MfSd9Fduzk/OT6kq9+vP9ux
	Qgk9SSgqdZPSkn42iZQM1eKa+BcA+Hu9L/suS9dldd6tkgklmGfTa4dJ+FN7Eg==
X-Gm-Gg: AYBFou2gAnduBLyW1qUkao5wWyauCLtEtyYOSEFSgVOPYYYkzzmLicR6TcjMDEpDlyd
	iPQNvFYl8YrqHSAiPySCCQzxpHpVvFPNOgTt4b19lxlYfT+rMjoUg1AMAYYdYBGUH08jmefPX16
	iC3+Y5JpBMHub8ZDYk7IKYl6pVMRMHQ3++0ZDJfhlqR2VQNsVONTmkgnVK3R1fU9nfMdJcjXxVI
	af7/E/n3fKS0WwfBpdm0+usiPCSF+FsdeqPM1llBajdfirZs9j5DuieFpWAAmx6Mpg3dew3183R
	p/8QpW87AkDgeTPmO7S/bCM4SHM3skOa02dhmmJb8q6MhSWIKfDBiEPcTWbMM+aBH3dwqwUZdwO
	qfK6q74x3uXaLdbdAM7YWibOPx+aUHWRtx4eirLHl0DRRDlCn4UwlQG+YzgMNXqU6AX5IFu+T7C
	mNFkGZSFUfUtDHiGX9SsDjvtk8KbxNlfr/7FBM/kL0tlgo7fmpNSou8SYJEw49ikIdlQBHO1OjB
	9H1s9hYLra6/YhHhWgqnpi/BWBELEPSDe6X02ocb6XNBC5XZfqpH5Iypo68T98vPNO26378/qwH
	C/Hma1TfJQ0E2JUxPlMyEJcfMmsHTXMDr2GaRlQmng2CFIuFe8bEMKnlR96rmFFwpBcjA5ji7Oq
	MOCUSfKoqOlizwNvy5dzlaLELtsPO6bYuWEbir4E8ZJMvS9s3aSqUe2TVPZz58EhA8ErJuyYM8A
	==
X-Received: by 2002:a05:7301:f8b:b0:36a:2383:eb51 with SMTP id 5a478bee46e88-36a423c4070mr5816413eec.26.1793425608219;
        Fri, 30 Oct 2026 22:46:48 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm11668877eec.14.2026.10.30.22.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:46:47 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] genetlink: Clear stale members when assigning multicast group IDs
Date: Sat, 31 Oct 2026 05:46:32 +0000
Message-Id: <20261031054632.3697295-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261031054632.3697295-1-anilkaushikwireless@gmail.com>
References: <20261031054632.3697295-1-anilkaushikwireless@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genl_bind() checks a group under cb_lock, but netlink_setsockopt() and
netlink_bind() set the membership bit only after it returns and the lock
is dropped. If the family is unregistered in between, its members are
cleared before this socket is one, and the socket stays a member of a
group ID that no family owns. A family registered later can get that ID
and its GENL_MCAST_CAP_* flags are never checked for the socket.

Clear the members of the group IDs when a family is given them, the
same way genl_unregister_mc_groups() does when they are freed. No socket
can be a valid member at that point: cb_lock is held for writing, so
genl_bind() cannot see the new family yet.

Link: https://lore.kernel.org/netdev/179340003139.3131.11274717768928642724@kernel.org/
Fixes: e03781879a0d ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 net/netlink/genetlink.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index f038f04ef4ea..0ddebd828585 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -452,6 +452,22 @@ static int genl_allocate_reserve_groups(int n_groups, int *first_id)
 
 static struct genl_family genl_ctrl;
 
+static void genl_clear_mc_users(const struct genl_family *family)
+{
+	struct net *net;
+	int i;
+
+	netlink_table_grab();
+	rcu_read_lock();
+	for_each_net_rcu(net) {
+		for (i = 0; i < family->n_mcgrps; i++)
+			__netlink_clear_multicast_users(net->genl_sock,
+							family->mcgrp_offset + i);
+	}
+	rcu_read_unlock();
+	netlink_table_ungrab();
+}
+
 static int genl_validate_assign_mc_groups(struct genl_family *family)
 {
 	int first_id;
@@ -527,23 +543,18 @@ static int genl_validate_assign_mc_groups(struct genl_family *family)
 			clear_bit(family->mcgrp_offset + i, mc_groups);
 	}
 
+	/* drop sockets that joined the IDs while no family owned them */
+	if (!err)
+		genl_clear_mc_users(family);
+
 	return err;
 }
 
 static void genl_unregister_mc_groups(const struct genl_family *family)
 {
-	struct net *net;
 	int i;
 
-	netlink_table_grab();
-	rcu_read_lock();
-	for_each_net_rcu(net) {
-		for (i = 0; i < family->n_mcgrps; i++)
-			__netlink_clear_multicast_users(
-				net->genl_sock, family->mcgrp_offset + i);
-	}
-	rcu_read_unlock();
-	netlink_table_ungrab();
+	genl_clear_mc_users(family);
 
 	for (i = 0; i < family->n_mcgrps; i++) {
 		int grp_id = family->mcgrp_offset + i;
-- 
2.25.1

