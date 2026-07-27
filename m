Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F1363086
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146280; cv=none; b=TVPj85tTwx0ZeNu4npieOf/QQhTXUJ7gIYslb/dlRptt2hSkF9zgq1qMGtGn1ehoGPQBi9u+mEXv/uc8wAJommsGOjsKyHcGZwmyhGXGQiomhLUOaxlcKJaC3VMaqYU9d58gFjIG+j/ezoCExlTJsukmUegMK1DHvOrWBKcHYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146280; c=relaxed/simple;
	bh=hksvnrMSdq2PW/vcmC8ra1BJNKLLl6/z6Q1cymyutok=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RLHiBg1mgbgFzlTel08yhjY9yueFpxpYrKzxCjLXTk2tVWYv07G6CH2jOXY6xNrPSUutNx69P2Smjn0ODPTefBJBX8hYL4dbciU5mvaSlTzre1OwgIL8UztJo36l2lPjatu+vAEsMLnIfL9Sn/jLVrtSvADg8B9JxI4fGEwl8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4K5owNW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fl3to1ma; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4K5owNW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl3to1ma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785146277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbVK27mEZzmZWs2lCAM3oBTkoawfDeeknGdjVrkh03E=;
	b=N4K5owNWlaNDm9FGVLTi+9/ETYd+bIROsSfZE2tjC5wxACd8CgHDh0c/5hRnlN0Yr2VMOa
	+Qvq/2mSTVFSzcLNAAHU1KOra7mTxt2niQ6cqyW8KqJCnj6rrInl6Ui+SIPLmSEhCHfa8J
	wlYHMKCpgDSXq97gmn7H1vB+FckARyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Z2NFlChQP8W4X3WiWoAK8Q-1; Mon, 27 Jul 2026 05:57:56 -0400
X-MC-Unique: Z2NFlChQP8W4X3WiWoAK8Q-1
X-Mimecast-MFC-AGG-ID: Z2NFlChQP8W4X3WiWoAK8Q_1785146275
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so2628636f8f.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785146275; x=1785751075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XbVK27mEZzmZWs2lCAM3oBTkoawfDeeknGdjVrkh03E=;
        b=Fl3to1ma/sl+E3J5ifxruwBiwKe/B2oB3nC+qp4TDdUzDTEAAg5UmKhDq4QeZ4uKum
         P6/kfLWd4zgkuUVnMlPzDzsVs9LiPtBUrn/8cs2w+R5L78Y4a7mcILx3kMqXjGOIfbco
         2M9bBoHsQEb+AGEkBH1WTN60Yxm+NVd6vcGN/a5Jarq43hmZhTRd7H2/ocbeGr0P6io0
         A/WZOLhJXJhQi+CpoVQJQOWk/rD87azkBYTuYBPXCC3D/B7KQFOeiAvKr/mwVKhNui1K
         Gp+zryamRcvP+DP4osxVJN8aW50I78+v1LGg28/V1MSie/bRXeqVeSenTmRDWHng21lC
         OYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146275; x=1785751075;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbVK27mEZzmZWs2lCAM3oBTkoawfDeeknGdjVrkh03E=;
        b=T21SWyAdW3YasFnmO2/OpsQulOaLmB5BkaGMbmsf+8EyvGRA1hmD8IU5hSzVws2Y4u
         yR/PQMjKR5J7FByK5EsCQ7TIauJ3iiCBA09clwagHo+ctditazy1k6+A+PrwrFueKFuh
         VJYw0fHVPUqTlhdE4Umozmngihw/3yrbclYA6T7lZyh70FNxyMl94Da3+Lr26Ws8AcIh
         C/K2qM1kE3+t5ltXcvwr35WBKGun//A30Iei6zUNXnWV3qdbPZuZRGD0kcG82t1h7Ydm
         S6IUrXMyp8dAbbQiXjxCzRxhNEpMK6DlUKF3NALWL/RqFf8toXatmFZnHUpE3vALPE3H
         6OXg==
X-Forwarded-Encrypted: i=1; AHgh+RoMD/Xt3HsMA3AHX2Q+OV+h8Fe/UWaLxAKAGMQnBdDHXLI1apgny0eWnI+V/qzfB73Yg/UcmkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypq8R6g+w22VpUo00/xKVrBR55sbJlr/NttJ4cKfFnqtaVEps6
	//V6PbeX0iTwKQEbihhfnHEmL8l1sdkiAFEnfANhwCq4u1D72uVq+WAt7Ej9/5KR5uFHvRctVqS
	yqZIxzhGGPFNWWSOWgx+zfLgdRKQ/t3pX10w04duTYiAhQMkjzOBPPnAmug==
X-Gm-Gg: AR+sD13FIaqbzWviX55TWLYxZwmUd0rEFcsHuIamMH/wBRqp1jQGK8j3FlGbn9mKmpj
	3r2lkWK2SwjH4puEtW4hfoF8v0ViM3PM/8ix3Un7ed6R3WiwTckNmItfQChBVyIaY+OYI+2HkTq
	qP6cVPvURWSEatgjFIJ1sOPOsMjjVesBH9Mj5nYHbTQTYTwaOLXaSmH4+f4iO2Ic0J6Emv6rnzX
	urkgDRLuggn/pRKU7hMHGXjN4W73NApjjFkF1G6c9SAIFb9mstHI/UJLa935V0oBrsFgW0Zl8L7
	MlcmDod8Pvdrc1jPlBQFqK7xDWQ/VOwf1P4nyRbu08QOCjfwK8gf6mjSNLDHdZPZGtEEhdoAyO7
	4ADCQUJ/afRWiNrazbkorZZTmxYzD/MuH063FE7N0sUg/mG2svF5QyskAvQyll5rHbLc5Pg==
X-Received: by 2002:a05:6000:491b:b0:47f:7c50:2222 with SMTP id ffacd0b85a97d-47f9fc8f0edmr10008707f8f.24.1785146274875;
        Mon, 27 Jul 2026 02:57:54 -0700 (PDT)
X-Received: by 2002:a05:6000:491b:b0:47f:7c50:2222 with SMTP id ffacd0b85a97d-47f9fc8f0edmr10008674f8f.24.1785146274443;
        Mon, 27 Jul 2026 02:57:54 -0700 (PDT)
Received: from ehlo.thunderbird.net (cst-prg-88-87.cust.vodafone.cz. [46.135.88.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bdac28sm46707278f8f.16.2026.07.27.02.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 02:57:54 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:57:49 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>, kuba@kernel.org,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v2_1/4=5D_dpll=3A_zl3073x?=
 =?US-ASCII?Q?=3A_remove_conditional_return_with_no_effect?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260725150852.859188-2-ekffu200098@gmail.com>
References: <20260725150852.859188-1-ekffu200098@gmail.com> <20260725150852.859188-2-ekffu200098@gmail.com>
Message-ID: <613FABA8-E03B-49D3-ACB9-175BF46ED165@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



25=2E =C4=8Dervence 2026 17:08:49 SEL=C4=8C, Sang-Heon Jeon <ekffu200098@g=
mail=2Ecom> napsal:
>Both branches of the check return the same value, so the check has
>no effect=2E Remove it and return the value directly=2E
>
>This is the result of running the Coccinelle script from
>scripts/coccinelle/misc/cond_return_no_effect=2Ecocci=2E
>
>Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail=2Ecom>
>---
> drivers/dpll/zl3073x/dpll=2Ec | 6 +-----
> drivers/dpll/zl3073x/out=2Ec  | 8 ++------
> 2 files changed, 3 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/dpll/zl3073x/dpll=2Ec b/drivers/dpll/zl3073x/dpll=2E=
c
>index a2a641b8358f=2E=2E0488ae6ac486 100644
>--- a/drivers/dpll/zl3073x/dpll=2Ec
>+++ b/drivers/dpll/zl3073x/dpll=2Ec
>@@ -2272,11 +2272,7 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x=
_dev *zldev)
> 	if (rc)
> 		return rc;
>=20
>-	rc =3D zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
>-	if (rc)
>-		return rc;
>-
>-	return rc;
>+	return zl3073x_write_u8(zldev, ZL_REG_SYNTH_PHASE_SHIFT_CTRL, 0x01);
> }
>=20
> /**
>diff --git a/drivers/dpll/zl3073x/out=2Ec b/drivers/dpll/zl3073x/out=2Ec
>index eb5628aebcee=2E=2E410d15b96d0b 100644
>--- a/drivers/dpll/zl3073x/out=2Ec
>+++ b/drivers/dpll/zl3073x/out=2Ec
>@@ -85,12 +85,8 @@ int zl3073x_out_state_fetch(struct zl3073x_dev *zldev,=
 u8 index)
> 	if (rc)
> 		return rc;
>=20
>-	rc =3D zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
>-			      &out->phase_comp);
>-	if (rc)
>-		return rc;
>-
>-	return rc;
>+	return zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
>+				&out->phase_comp);
> }
>=20
> /**

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

