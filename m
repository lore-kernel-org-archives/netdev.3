Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263394DEC3B
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981605; cv=none; b=qAX/xwcrC1hnaxXH84qgpiKU8p0/qC3BSoxJeB2BSVsBa82kka8skWFAMD/Yr2Km3Dt5xpwjW/ft2f4Zhs9xLiuc4GpXvXLhSLzXGOnUpnWImWPEV3ydCpWVasU51HzTt2UFp9JuPFzR0VxCcbeg2hFXtFXADkgU6tEYbWWHoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981605; c=relaxed/simple;
	bh=rkcA+Jt2EHcsgiHO2SpiPIETk+jNu8tDWoLY60yV/b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6V1+QFep3TjD3QZ8YLCb3bJufzhEeLTFUV0gJ8tDX/GkJEkrLE5mx1Rn20MERIFi/Oy5diGG9kE/nIDvnGMslL4LeDgXoX8TV6XSehaXlb7ax2n4sPVhpLVtfwFHpedReByijhDaKgOvE3KP9jbJmd4BcyWWHffWotEYT+Hnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/S8zjyz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/S8zjyz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a061a13884so34907185e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791981599; x=1792586399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJnBLC+e56rl7jB9mQI+MGWyd+9ndujkrii0QT8LXII=;
        b=J/S8zjyzSHqD+QUMuSwI4bg80znCuKw/wO1qF/6WwCniqaUAiwSGjtFeI0r+ESFIvo
         miL7SbRhpwZmFK1Z5U1Xfl3NEg/QRnv50byOVsPyxlF6HcNWbrbf6xZBwaOB8HHvIYKr
         d9KSS1sRaGHrHSrUyLSebXrGMoK+1VpLvhG7KWZMPK1t/TfYBTYxzhf3USs3+o5Bf7Py
         6NuA9vGmSeWJlKnqsAqvD3wboxXwTar/0gI/IJTtL7K4iJ+hVq7o07e8CPAuvrc64yKZ
         kINzZQSXtNqo5Z8TLpyZzGivUrYVm2okSpXAJ3xYumVsMB4nTwZiyOlAecIM8n5B3v8s
         ViDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981599; x=1792586399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJnBLC+e56rl7jB9mQI+MGWyd+9ndujkrii0QT8LXII=;
        b=pvGVIPlO1eYTdQI6Gl3GxBRvRY2l4ATBIQMWUFmXCHMWwO3jU1Q8gfWiwYx4oDayCa
         5KwPT0L7DA91+i5u4q68GMt1/xkRzHzcoj0+NzaxyWyDW9NNuQZPSEMhmXFvv4I1XPuh
         PnYUFLLzmw7XAtLctVM4CSsdhB1MQoYRUf+iTf6gSWSWyYGoS5lDx0czFMSzT0z9QkDJ
         feDB/f0KnhnFMlf/bDiNpq/cOFsXczwJ0a5Ss9GbXbFCBWaS/jlNMtTfoxQR1dqRKQxz
         zi2pUR3DhrPnDChASkVRe8Kayn03PZBK3otdbU+Nvz6MYR5TBFHTDmQA3MRW0qgGWpHg
         MGyw==
X-Gm-Message-State: AFq9FYLk2ZP5G7i3E8De9AtyEAxbN1PB3b4l3glLGB4XReMTf5OmsKwc
	QT+hIYk1YtHXaC9JngM4dNG4/3cRWTi8ZJ2RmG7z+HFIP1FaikKmOcoZPfR1jd6q6S4=
X-Gm-Gg: AYBFou3Q3EW0uVWBiVtFwFsEv/ZNWlO7oSSyFKCTHerrcQ+Y3ZYsokSYeDqKlH0aHpH
	xTOqpafdXRTlRrI6rpnEHwflngnNFYCJAQucRUVCa5x51IXaPaFCvr53eD+TsyBlVuiRV+MyjPo
	j903qGa7wwNuVwvpZtNQFDBSDEpXLbuUdAV6NB8qm/SxpV90W4HkIPShHPetnGLayxdbRGyEfr7
	iFm6EGV5MhY9z6UWqk4oPJHuE4s7DodaQYyfCKwP9hgijrul+xkGrGygjAOMre/V91DgkjavEMd
	WIt49Lr0RxLtllhIXCQ/pimxvFJl7m/f2z3yVeNyBkjfmzR6ivnTaa2/5+4+gWgTgsdWxJuv5e/
	ykFnahCgWhyDuoWTKw221tgpJOx32QQMfFBtSi0sTIeVcVQZkclrcCaNIOqEPo3TIIG8YjtOU5R
	i3F3yN57p48o3VfAxAqHO9Ch+IbrbFbQCf+NfGFpb63VD2ZppXwqecN7pKZwDot8gLUJEDhn30M
	Q==
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr286173745e9.8.1791981599094;
        Wed, 14 Oct 2026 05:39:59 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2ec47fcsm54163165e9.1.2026.10.14.05.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:39:58 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v4 1/7] vxlan: vnifilter: validate the VXLAN_VNIFILTER_ENTRY nest
Date: Wed, 14 Oct 2026 15:38:08 +0300
Message-ID: <20261014123814.388557-2-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014123814.388557-1-alishmery18@gmail.com>
References: <20261014123814.388557-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vnifilter_process() parses the message with vni_filter_policy,
whose VXLAN_VNIFILTER_ENTRY is a bare NLA_NESTED with no nested policy
attached. The entry attributes are therefore validated only later, one
entry at a time, by the nla_parse_nested() inside
vxlan_process_vni_filter(). Entries are parsed as they are dispatched:
in a message whose first entry is valid and whose second is not, the
first entry is applied and its RTM_NEWTUNNEL notification sent before
the second is rejected.

Link the nest to vni_filter_entry_policy with NLA_POLICY_NESTED() so
every entry is checked against the entry policy up front, before any
entry is acted on. A message whose entry the policy rejects -- a
malformed attribute, or, with the next patch, an out-of-range endpoint
-- is now refused as a unit and installs nothing. Faults the policy does
not cover, such as a device or handler error raised on a later entry,
are unchanged: entries are still dispatched and applied one at a time.

This reorders two faults. The nest is validated before the device is
looked up and before the vnifilter flag is checked, so a request
rejected by the entry policy, aimed at a missing or non-vnifilter
device, now returns that policy error where it previously returned
-ENODEV or -EOPNOTSUPP. The request was invalid either way; only the
errno an operator sees changes.

The nla_parse_nested() in vxlan_process_vni_filter() stays: it is what
fills the per-entry attribute table the handler reads. It can no longer
fail on a message that has reached it.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20260921150904.65a704eb@kernel.org/
Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v4: scope the "rejected as a unit" claim to
policy-rejected entries; rebased onto net-next.

 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 41095096b698..124ba47758e9 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -499,7 +499,7 @@ static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX
 };
 
 static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
-	[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
+	[VXLAN_VNIFILTER_ENTRY] = NLA_POLICY_NESTED(vni_filter_entry_policy),
 };
 
 bool vxlan_vnifilter_has_multicast(const struct vxlan_dev *vxlan)

base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
-- 
2.53.0

