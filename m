Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3933D8123
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704393; cv=none; b=U/vrF/hKpEbM3JB4vedoDFNude6ihInlyV5VVA54jpHCgPA2ZeRg7zBihKFPGqt7z5dp1kir8X+utaHTeJ6lZ+xKfxL5rO6pdX3p952hieb2p4Mx0wjyGZ5j2SUx63R0VH4qS0aPHIAviZwC+bi0iluNNQptOgIPB3/rAutyXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704393; c=relaxed/simple;
	bh=8YKa5Bqth0IIk+EC3d0YaMMCxQVa+lDu0NS9FLv723k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRHocsGy01l5X1aDgZ5TVcdLSliLApmDKplGGBIlCejVPCjW0rEnw0pBfV6shUO3uEoQHEO70CeKtGe04cgmZzgqSZ3Oo6bt1n+UzUl1mDV5ToPcgRmcchYK7HAtxEI7ha3siOjJH9jNKJnwPOgkyC8zLOqOR2BJSC7xyOF8dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=zZzt/5rw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="zZzt/5rw"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2637dd37c1so93996666b.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788704390; x=1789309190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81ted4pMTbnzF3OTQRL5I6LA+qBpd0cXl1PuT1/p3yM=;
        b=zZzt/5rwn3tAl0SbaPAQ3Zs4YsFqv83NMIHDkN5rjYziUXdCrPiNeNU4h5f3zFRZuj
         hieUqRJyLABv6HoOguO9ioRnSRHquVbbBrg/L5TvLlncg9aN7P3aRUp2NVBtXnq5VORp
         M+CO5HaaMY1IenKQJRxks1bjqzm6sjbNjatA6EDdmoGGaWOmlR7cTjLfVm+luhGG64T1
         RV10lEySx9Qi7+97GGZYu8kNO7olOj7HXsn1kXEEOAhGG+1ywnoYhe8KQxiUNo6uDhtR
         bePAIo1Xeho9bsQ/H4hYHVms+kW2s8PqNRskVSw3weAnmAPYu0SDhKw0jDSucF5vQKaA
         OlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788704390; x=1789309190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81ted4pMTbnzF3OTQRL5I6LA+qBpd0cXl1PuT1/p3yM=;
        b=eDIAYn4okPdNIGZ0IQYKUYUe3ViCNOFBUigO5amxWLfwVgPyqTYljK5bOo0H9+fe4l
         Bnkr4UTPF/7DMe1Fb8yZ7FxjAGDaVfB76F/fjLcpXZHQCTB+YwvOXmln91WeMU9GCkSL
         ozBdcu4c2xSO8/M1xP6TFDnnUwulXz1PyKBoZhZjxz5F5MREBG5fneuqZUqSIWHejlBV
         GE3pQLpD4bZK8wgziUJDe3wWh5D59eXWv6R8rzlFfl+ZEKDhioU5eXnLHsLPne3n8civ
         kyIVLMrSUkvggIyBuu5Q7yBwbY0sexCxDaqMtcU1EngcXa5XyCwHcLBbAE6IB4FbVmpm
         5AkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNd1HjvZYZnhXvfWFmNoMKbfMZKin1zOW7cxfbwI1QRXUyDruQaSwThMcNaYZym612Mz9Y50w=@vger.kernel.org
X-Gm-Message-State: AFuF++mRJU76zAcqMmDuSgthBKE800QVquLJ6leY4Xk1cuEnLVSefEKa
	DMggCXpBgQKbS1CPqMXF1vG9SDzDTxp9n+bKTI9lKzNY9VcSH6s9EZup3+5DnJEyfA==
X-Gm-Gg: AYBFou0pSuRIXZ1pmwHiMpaODIvQJ4wLoBwkNCrS4XisVg7vIBaEVLt/p+u1B9M/nUd
	O9bNzlTW6kSue6cq85YFp/Jacji7vhGLWYieFUaGSw/GKrwVTehc8jq41QuyrjyJc62JCPQgi5h
	xixe13kDQsn7AC57MEfoYuzdeNOC6UwRvwGBEfmZlzHuPw3T9iQlWxWR1DW0JKybvygB11rFcCT
	0jUSHSDMUMmiWyL+hvFQBl21OzH4tv0Nd2zTAjKcZtiFtHJA8jhKs4lHmXy0mCS/gtlsKkgKgvr
	ZGrvIxxEdOD9mEdOyAWLNznQ2QPyWsx7+acdwPTl6WkLlyzBZe3R+HH23OSgOvG0L+fzAdEtYxP
	nO3yY3EpCaAGjG9DLkBfJJxZFgxS6TYpSxHom614tScUYLCoKJea4k6gy4thkUazDikF6nUl8lf
	mNtZ5m3DC2qslQXiua+kNVMuaL6PdOOT+sz4u518yhT9iToGVffSgRT+6GSmMK5veWXD0hQYGHV
	kCCM+4+h6HGdh+n8rKVTmREKfr5Ff7ADtxbE9ZXEC++o5YTPIKHm38tdszJJwJL42kYhUp8lE8A
	ljz2TMcBkijQRcpwUe0EHjrgrWQyAVIrNe1Y/THdfg4J/IBHlVAoVYI4tZv3dcVhzsRWKFjubEa
	Ar+Hedl8cti1vNCNI9LQhD5MAMa2HKHgVSvEK3VPX51tr42Cd2Fb9jkerWyJ0gU8GhI/t0jo=
X-Received: by 2002:a17:906:f591:b0:c20:f529:2d6a with SMTP id a640c23a62f3a-c260ca339fdmr622399366b.22.1788704390262;
        Sun, 06 Sep 2026 07:19:50 -0700 (PDT)
Received: from Desktop.fritz.box ([207.22.59.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b284bsm342888466b.51.2026.09.06.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:19:49 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: advertise the vlan match in used_keys
Date: Sun,  6 Sep 2026 16:19:47 +0200
Message-ID: <20260906141947.480524-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_flow_rule_match() fills the vlan and cvlan keys and sets their
dissector offsets, but does not set their bits in used_keys. That bit
is how a driver learns that a rule has the key: flow_rule_match_key()
reads used_keys, and a key the rule does not declare cannot be read.
So no driver sees the vlan match, although the rule carries the vlan
pop action built from the same encapsulation. mtk_ppe_offload.c reads
the ingress vlan through flow_rule_match_key() and so never gets it,
and a driver that checks used_keys against the keys it supports
installs an entry that ignores the tag.

Set the bits where the keys are filled, like the other keys in this
function.

Fixes: 3e1b0c168f6c ("netfilter: flowtable: add vlan match offload support")
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/netfilter/nf_flow_table_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 801a3dd9ceea..9ef89127bf25 100644
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
 		} else {
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

