Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051269;
	b=N7OsWDiZ+jG72+obuX7IurUx5NTeuhRV/D6pSQm9vOX7jFJh6U7HwOePy9jCWC8uLx6P
	 uuh2b8nzhoQw48SayXLh4PLuHeinFVRvH8Xc+gw35Yeh+JPU0UU/wQID0IlgmN5ZK572X
	 aue1UUcyy28q1fbNtXzeXYqil/rGzLzpVVQL3OaDnaZqeq7dKYUhatVEYpzKXwhmLwsdM
	 Gz+d6Tg23adPuRoWl46h+fQ59vuCU6ORqXDJpTQZ6pcI425qUkkDvg/oqMzEl0/zYTLrC
	 MNDRA0nzvX76SvjnrQ5ZcA90mHVCqlEiQLMYa7xzZmxubVyGqaMaFbLhCkgmSMOHK9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WrVSJWTebXtE+tU0LnNFvBWtkbGDoltWcoJtcFiPaXo=;
	b=xp+NqJV24GXEozKlTjX8cNDUuEQM7HMNoyVAX1+CSN7rbXmWusVYBGp9eAuuHafvwoAy
	 GlKhobXVw81pnIG9rY8q4LrK2vll+lZvYet1yv4R2aLEW0cqN2th32Yl+J6vXyuBgvD/1
	 PoTDynpG1I9tLoq73CcLC4gxpy/1i3qt5c7GE3mKFpFqYagh3auZ/uvLqRiy5GD8Q/C/a
	 FSVwcemKffPNwUbadaHS4jDuZGT4WXTC+qB3VKLA6mwOGqBABv9bc6rt29SUv3xRWIF7A
	 SrYHW4enrFe93QTSYyZhsGj8IPyD/6UkW5kUhJ9+x71VOkdpmmi6uW0WQXl7lg8woHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTqVO+v+;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149D606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 11:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9149D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTqVO+v+
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso18260447b3.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 03:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794051267; x=1794656067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WrVSJWTebXtE+tU0LnNFvBWtkbGDoltWcoJtcFiPaXo=;
        b=fTqVO+v+l9zGpDJE2j6M3+FmBdSTXfasWwU4SWxtS0hOuu08+Kms2MRpWzrhhRXSLS
         04b0IvOeMIHpOFMsaCsQy7wr0c0rOfpa8RwwVuC+QVT4FKxtrSJGLK0S4mI8j1qPLDK3
         A2DLgUX0zlzJT9Hc3vINcnc/uJk4tM7dD9knnQwcfAX1UbHqKyfRiSBo01jLnr14MMye
         WShn6o4cj+AHEvzZWk6asZtTmYHsyllhtDiKtn3nxRoKdx+5LhTwpV3upIldocSZtFtn
         ToYThxDLs/MJzC0RUK35jK3wiSDQ+A7z0JwH11C9GA13jcKGGvfgU4LkcGDh87If2s7i
         qBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794051267; x=1794656067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WrVSJWTebXtE+tU0LnNFvBWtkbGDoltWcoJtcFiPaXo=;
        b=AAkgxiKAMh2YymyAm0lHfWEV0S/N4OvODRMlFqH6kC2uiSsvy4+ooKbUurfrxQ3tki
         nY9++UtASxzL3ZtRcaT7k80ohKpyFRPB8gVRsoLV1kHOOpGV8GlhNnsHy4Gh4xW9bsqO
         AinMT1QqhKig1ArTHidUITktMtwJJklb/OqH/um2FZVr0WjMms3uDYPNX+2s6yfH3vUK
         jqGGFjuBVgzVTMjDGO9pTENEkdYhjdK5a3ul7H1OWjvu7mEtXAZraYyb1Vl8Lx0fLWMK
         di3wfV4++59o2KXrzspTYXsswsgciMvhIi29XS1lnTpM4YPVnzGkE3UEg4jIhNYaZtQl
         m4YA==
X-Gm-Message-State: APuU4Z8EMvVPQGMfANpaoCPwVaZNGB7MSJancmji9IBaT0haNRXoEpDB
	73hzecJJCFHUslBcvDw/+0t/LJy43cvPB7B8JlXQLF38J16ELO7uQ6xneAGpYU67
X-Gm-Gg: AYBFou3sR9TRal34Y5Re8aqGEs/kENm3voHogFNBaDwhb0M1G5v8qzwCP2jWSCkgWXp
	8g5I1IsWPbGIv5IN8FVwW+QFR5uMh+GqqYK3tT8BgKF4VxgSug0otKK4R+apyRX+vcGpzWQ/Hhm
	vihf67rDwPDe8kEX6EPE3iey7c1cN6BtGtpSkJ7qm4g467Z+ZnS/MRcuxQSwrEORz4TKOK0LNn4
	CJMKU5utzHSr3aEWatdqRgYtHxj4e2spZdNs1rvBhqbL5d4yx/pnAfT+j0p8WWur9r5h0Ryt5c4
	LcW42Atvtk8WVetpFvn4blBS7xinfh0V8hXCJKyhtSX3wJwQv7O+3ZU9VAedbxVPNf0H0joiUtT
	OiFKlJ6+2Yn6ah4taWGMg6ibCmbE/OASl6NldRZRBww7kwZRSFJZxIwCDovl7/ccvfj87cvqmdM
	eJncdJQ8vFg3cCGk6QTu2w+DJHoNfAAShisYnWu1CJ8T+Gh7y51YoKPCYEN0LfNyfvmOuMnFnQa
	Xptv5PpSsBLUHj96TgRT0WJMy4G6lKKWhlKWG+25L7gIYLeevr0nJfYBsEZ817Y0aeQtKs8zk1n
	0hEuro2jpb3wRN9a0AXZX5fs
X-Received: by 2002:a05:690c:d94:b0:8b3:2d51:a839 with SMTP id 00721157ae682-8b34199590dmr32831887b3.40.1794051267434;
        Sat, 07 Nov 2026 03:34:27 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2d5dsm40084597b3.2.2026.11.07.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:34:26 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paul Blakey <paulb@nvidia.com>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v1 1/2] net: openvswitch: do not record user features when the change fails
Date: Sat,  7 Nov 2026 06:34:02 -0500
Message-ID: <20261107113403.797779-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107113403.797779-1-houminxi@gmail.com>
References: <20261107113403.797779-1-houminxi@gmail.com>
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

ovs_dp_change() stores the new features in dp->user_features before it
updates the per-cpu upcall port IDs, and that update fails when the
per-cpu-pids attribute is empty or its length is not a multiple of four.
The request returns -EINVAL with the new features already recorded.

The features decide whether the tc skb extension static key is enabled,
but the code that enables or disables the key runs after the failing
call, so it does not run for the failed request. dp->user_features then
claims TC_RECIRC_SHARING is set while tc_skb_ext_tc_enable() was not
called, and a later request that clears the bit calls
tc_skb_ext_tc_disable() for an enable that never happened. That key is a
reference count shared with cls_flower, so the count ends up one short
and reaches zero while other users still hold a reference. Recirc
sharing in every datapath goes off with it, as does the skb extension
allocation in tc, in the flow dissector and in the bridge. The opposite
ordering is possible as well: a failing request that drops the bit
leaves the key enabled for good.

Keep the new features in the local variable until the request has gone
through, and use that variable for the enable and disable decisions. A
failed request then leaves both the features and the key alone.

Two other paths touch the bit without keeping the key in step:
ovs_dp_reset_user_features() clears it without disabling the key, and a
new datapath that fails after ovs_dp_change() succeeded is freed
without disabling it. Both predate this change and are left alone here.

The selftest in the next patch sends a set request that fails on an
empty per-cpu-pids and reads the features back; it fails without this
change and passes with it. The openvswitch selftest suite passes with
the change applied.

Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
Cc: stable@vger.kernel.org
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 net/openvswitch/datapath.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..00043aef2d03 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1801,9 +1801,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1812,10 +1810,12 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	if ((dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
+	dp->user_features = user_features;
+
+	if ((user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
 	    !(old_features & OVS_DP_F_TC_RECIRC_SHARING))
 		tc_skb_ext_tc_enable();
-	else if (!(dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
+	else if (!(user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
 		 (old_features & OVS_DP_F_TC_RECIRC_SHARING))
 		tc_skb_ext_tc_disable();
 
-- 
2.56.0

