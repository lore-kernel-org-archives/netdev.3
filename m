Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0A3D890D
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704422; cv=none; b=J17ZxH3uYl2peGYNl/WdEqkkBj/1B0ayT067CR+2jko9ivX4vazmjgmU+bYat6iP3cLg/kL77aIAc0u6+LLAOfkf29PHZ8sGXL/4f3nlzEnQAo5pJCM0TUH9NoBFNtf1nGnUxe97WYuWZmGlWwCDA/4wkg+7fdKILHCG3rJOXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704422; c=relaxed/simple;
	bh=8YKa5Bqth0IIk+EC3d0YaMMCxQVa+lDu0NS9FLv723k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3z5s3cU/wEMcREI1yeevbCrYmvoYvPSS5fLw1ItelB3lRTL0NbLWDV6MkZt05m6Pdodr/4Ts/JbtTfvBXeKLjQtTjsFEZOG67Oc+Hs5DuoBvv8pQauyc1hMOLGYoFfYflGDVgLD6atVjuMaWYfjo7Fm+GTE+GOSPgatf7+E8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=wwSbD2+O; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="wwSbD2+O"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c25b661d37dso356837866b.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788704419; x=1789309219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81ted4pMTbnzF3OTQRL5I6LA+qBpd0cXl1PuT1/p3yM=;
        b=wwSbD2+OszJtm9MadMRj4FnaZrp2TjoAKobDy6BkPkgX9bM9M1PiotVAU6BKKCx+2E
         YPSxxv1/T1v8WijOpqllPTxVWqvZcKSIjSinNTyRgWaQdI/+YT9gE4+cLPsMHGjSxNpT
         c9OoKR2KuChKnb1zFhgBCWauvaUDUAThu/3i88YnAKd2mHPHJPM5eekxunnZ1qwlyhM7
         U8Whdvv8z0V8ypgb+QYImOpb/SofUv+V5QEjL0EZMNm/V04S2r1EpHcsXBXuw56CZ4Kn
         /tRfRKmrKZ7SLLOh5NlKb1jkbe092LtGeNojpFNpj7tuD+QlSDzk4jlRmKj3sTg3DsQr
         A+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788704419; x=1789309219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81ted4pMTbnzF3OTQRL5I6LA+qBpd0cXl1PuT1/p3yM=;
        b=T8Bux/Tidw3Fj1Ij/qf+N/HnhJ5tB1rE1UfmpfKbi77skfyJxZm2aqB80/DZtMnH+g
         PuZjnNo59S23vHd8vHSRpZbPe6Dfo1PY58AVMPJqp++UYEWylWOAXOXaN+SRwRiRaV1J
         lnblceV1761Tev78W2/Z5g9gYtvnzP30XGrGmlHmAU8qeSu9RUaCxRshe1xTF3g7KtVq
         H4SCd5OUV+qWwW0G2bTjeErXqgr+KXp/2+s6HAPrWN39lVSZbHXvuU4E9C8d7RMepEq8
         38P3+Ns/DRZkt0PRffFsoiY3veFQ64ObQFKDelSNhj0aHI/GROlXMKJrhfB4d+gnG+Ax
         gD9g==
X-Forwarded-Encrypted: i=1; AKwUvBzckDjoFtpuivV4GexdSmxpsJSSCWZ9WKzjUx58SPdByGnocdTu6C/FE44wNFg9nf4p7+p9qPA=@vger.kernel.org
X-Gm-Message-State: AFuF++kO6xFWLuiSqD5um2YK4oJnHM+tJtH5AU4SS3FtY2SPZL2pAEEY
	bI39yDRqRDVdF0HvlAqU+hZ+/lPKVtkiihnixD+VZmFVS6I1Nyi4a7jED1IzU0fhBA==
X-Gm-Gg: AYBFou2bvdaGGiH8vcKLSOmIGxRnYAARuICS7cMpVAAIgw0YdtKPcScB4a3yL/mRy2d
	IgQrz02ao/Rl29/y1NyirAeo2MWPkCQCp0oCj8/yKkbkZbRXGhBIAbOLi9+32o5ZROklow7+0jw
	LefadCcv8TP64AIJm5ZVQIJrgRMPpXtkpTA5+Z6LLcOzdfuM0lgRbfn649BoGfZvvvdWri5hy7r
	FuMui0Wn8Yts09kvtpvIcv3uS1Rq96VFtZFaxqXXihFLK/ckQRQLb2XVwm5GvSeO6cIPeYxwIBP
	DG7GeRBDUHR+PC7WT2zAF/ig3utQDtdHis+KlbhqoV5mM2GVBoHqBGM72tHGxxUMzl6WWPoHH/K
	w+dIqG92YUiu1YCsvINLRUZoEyRioUFGax/ODRUZlwZmTV2nsk7h28KkUw9gWqUGUSosU/S+5Ub
	KKBxb3RyKggURjllkMIvrQ92soZHGIODLXFQYoXMGltvCb9SbBUcEFZ1hF4qzeVPYGD6QjqB4F2
	u4eh0M5N9OKLva07RNecnOI93kV0HU5tWoMu+gj/wlsZjW05YHPGrog8B5D9ZUnPhcIwJIBR2Ja
	/Cp1wYwpc15AEPCy72posF5VIGcIhAPqgfgFTKW205lBow6gw6E2akFe/cXfq8H9EVkyw0RCYNB
	TfoENoW6dGpgG4w8YTNaNhu04mPVt8th8tMyOa+9fIA+pHHKXmqBR8lqsqcfjAMCaXpAD7q3njU
	ctU5x1iw==
X-Received: by 2002:a17:906:7949:b0:c26:19e3:e989 with SMTP id a640c23a62f3a-c2619e3ef5emr537106066b.41.1788704419230;
        Sun, 06 Sep 2026 07:20:19 -0700 (PDT)
Received: from Desktop.fritz.box ([207.22.59.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d581f51sm354248266b.42.2026.09.06.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:20:18 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: advertise the vlan match in used_keys
Date: Sun,  6 Sep 2026 16:20:18 +0200
Message-ID: <20260906142018.480577-1-julius@bairaktaris.de>
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

