Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BD3E0C73
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296177; cv=none; b=D+e3Gh0F35zJKAbVR0uhLVXGBj13AWbotNFi3g7GgDvlsjfZBaGjAvxtnKCoZLskzGehZay2eoEyTExFojTSRcUNBjQNEsaoXu01NdSdzZpVzV+4avJz+fWhdvVKqxp2rkXPXpg0pyhcl3n90kminLiOPppJn3I5NkPU0QpYTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296177; c=relaxed/simple;
	bh=lGehwXEZtaMbMKO1wW9AcdFWi7zSdBA53XIp6hr2YUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Voi0YjL47Wnbl8psmuLEyc1v3lXfEqGIKcCNcG9aldpNH3ydYXl1zBHbIllWMLjAWhiN9HnCzsLCsd9N76KEof7Hb1WuMMf69ZcSskiqS6ZPURV/0Ec8rZBBmoQdis9UAjWzVjQ8CZ9dwhubQhqoOP6zhwDLZM1HecRV/QOAUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=V7OmJA65; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="V7OmJA65"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15d3so163788166b.2
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789296174; x=1789900974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Had5sqsucFv7bjWsA15L5n3iBC86r5TDHnTj1IfvOg=;
        b=V7OmJA65N4WoqL5fDkzqKn66IkHweoi+1vJPhOHVPAI+5ufxI/3zDIATp0hwwaGnfH
         agQwaDUWclunTmC2fDWbImhTZTfGXMbsfdU9nnpvtw+NrxGzDXFUIrYyfS1le2h4nftJ
         ZCSY6eJ3s+EVu9VKpTdCEXoYcFBwOuv6WBOtD0PBSRNpBob+OVpcfnyIhro+G3Lkl1R4
         niZ0WrG0Xcx/qi7y93V7gB0Fv3dwSbW+5cbciza0LEAZBMOgMHYHL66flpVS9lYUwrBR
         xGqnKxylnUt9D7155W3Q9RIY8wS0V91dFHxsC3wXSHUiflHLTB97zZVwwRpF4NjInxui
         1fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789296174; x=1789900974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Had5sqsucFv7bjWsA15L5n3iBC86r5TDHnTj1IfvOg=;
        b=pWbikl9cuIZiTUH9cZHY0f2muWPFVkVg+lLxcOkcnk/m/8SzIIYxaiNlIYxmFi5cav
         PHnL58KR0HOli4+JgZBTCzYVRy+F2tT95hHHI7VVNkvEfIxWMX09OUlHFU5Q1VtOOUez
         WHZ6jQzKv+G+j2CcWa0ettDWglFimu5SNiN64QXrpiIGrWvx4xgSAqfuKr5R7vVolEW4
         vCdO9rkNPR48B4ltERkKz1907JAMXTsoDLWrQ1wH2nMvBg2ax5U87mgqZrh4zIk3yAUg
         9cq7xiGrathh6uVyZUnrPlsZKiusZTybHfGRFEtfEGTq6mmNwrt2g4icB2VR5mIoBnY3
         1mGA==
X-Forwarded-Encrypted: i=1; AKwUvBxnsqFiTcz5IA487rmcOU//v3IDLc6/rWfzJCATxdXagJ8Io4LmB5rQnzVq8barJn1YW5+7LGI=@vger.kernel.org
X-Gm-Message-State: AFuF++ltAl+1vfGnbWh7lqXmjtzFQMlMm0QP0uqwOlSAAYYOSPDyiY46
	f3WOoR0s6dA7is9hox442l1MuBFZmV+taHQylKSUlwBJgVSSNX/xtBn0qOE8MYy3uQ==
X-Gm-Gg: AYBFou3qFVbFRpNY5l5uRLBgHKkTrmnlUp7sAF5Exs9bTg42fqEWWMxZGu3pQlXRCor
	HOa018HcwHO6mejCZ6Ce5eli3Qgod2s33+ZDuOksREWGUnsfnGZxpQISYGXccwLvWQvJ9fHrOxd
	7R/UW2KH99CGoMrBVOPHn018rGleSXt9UZkUi+DfsipUq0+Qy7mD6r1n9WpImLWFfTp8YEFdnOk
	9y+RMwYqMjIVpa6mcr3L7cXD0ZR1STfYnhN/RsCl74fW+rqG+Zv1CWEW9CfE4YmZUhj8ZYm9w9v
	t/8d3qxjsbMEuxP++LY2TG0nUhzn5SLqK/8+m+bDhJwB7BJElT0E3W1+o7c5//OLWT+pSrKiwfF
	5m0CagACF4Ykw4PdAfN+iECWwAzh0WDq8FnfW5qSydYQPPW4l8tj/trva49MRSZ3V7ikTjNwHWk
	VYWDhPBosOTHMjbybs34nGQpKYZNHeW1+Y6MwD7yfT69gAYbRB6XC/rOpSFtFTo8ZoCJW0ATBsA
	SbenNbCYvTxZRshICaRiT7//i8kSXD/XIAAtEwc6UdigZHVEOjyifHVc198+t0GkRztQzhmctVp
	x+cjLZug1L6ki9nG2sxkUBjxGpIUw8sbYWJYxyDcYxJPnN37ETrzExGxRSEzRAEbX+UZhFJ1q5D
	lZAWLmdlhmbijsNZx3qzOYNGU4ctFlt6FGvTs98uCLE87Js6OWKU8oWhGNkiIdpZlhjvRolSTna
	SXQVMKRHonvwlV//hBv8FUJIjnIzLSe8Nmvw==
X-Received: by 2002:a17:907:3e07:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2966694b2emr1062643666b.11.1789296174284;
        Sun, 13 Sep 2026 03:42:54 -0700 (PDT)
Received: from Desktop (p54aff833.dip0.t-ipconnect.de. [84.175.248.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296605b438sm278678266b.26.2026.09.13.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 03:42:53 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	wenxu@ucloud.cn,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Subject: [PATCH nf v2 2/2] netfilter: flowtable: advertise the vlan match in used_keys
Date: Sun, 13 Sep 2026 12:42:51 +0200
Message-ID: <20260913104251.648421-3-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913104251.648421-1-julius@bairaktaris.de>
References: <20260906141947.480524-1-julius@bairaktaris.de>
 <20260913104251.648421-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_flow_rule_match() fills the vlan and cvlan keys and sets their
dissector offsets, but leaves their bits clear in used_keys.
flow_rule_match_key() reads used_keys, so no driver sees the vlan
match.

mlx5e consumes flowtable rules through mlx5e_rep_setup_ft_cb() and
__parse_cls_flower(). With the vlan key undeclared and a filter device
that is not a vlan device, the parser sets cvlan_tag in the match
criteria with a zero value, an untagged-only match that the tagged
frames of the flow never hit.

Set the bits where the keys are filled.

Fixes: 3e1b0c168f6c ("netfilter: flowtable: add vlan match offload support")
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/netfilter/nf_flow_table_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 19adc6c7725f..c50bbb1411d5 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -126,6 +126,7 @@ static int nf_flow_rule_match(struct nf_flow_match *match,
 		nf_flow_rule_vlan_match(&key->vlan, &mask->vlan,
 					tuple->encap[0].id,
 					tuple->encap[0].proto);
+		match->dissector.used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_VLAN);
 		vlan_encap = true;
 	}
 
@@ -137,12 +138,16 @@ static int nf_flow_rule_match(struct nf_flow_match *match,
 			nf_flow_rule_vlan_match(&key->cvlan, &mask->cvlan,
 						tuple->encap[1].id,
 						tuple->encap[1].proto);
+			match->dissector.used_keys |=
+				BIT_ULL(FLOW_DISSECTOR_KEY_CVLAN);
 		} else if (tuple->in_vlan_ingress & BIT(0)) {
 			NF_FLOW_DISSECTOR(match, FLOW_DISSECTOR_KEY_VLAN,
 					  vlan);
 			nf_flow_rule_vlan_match(&key->vlan, &mask->vlan,
 						tuple->encap[1].id,
 						tuple->encap[1].proto);
+			match->dissector.used_keys |=
+				BIT_ULL(FLOW_DISSECTOR_KEY_VLAN);
 		}
 	}
 
-- 
2.53.0

