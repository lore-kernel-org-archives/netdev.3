Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757800;
	b=ej8o2SVbs5hmnKS1lI8ZMkC44mNGI44X+WaLHFs0bvjM3r54ThGlKBUl/oWuiTpYKa4F
	 kB9ri9N1bhKIoSfLX2xcBPRN7mkHJEaZlsZKfSZZORZi7rXGo3+rQlBM5yre0b/LZLlc6
	 KHXcXm7MByrvwQ5ZUFQ+2z9LcXUwtoFtu2bVfB0s7ilLBZfoZ6d5Ol+uvIT0+Ie8K2yK9
	 EGmvQ2QoQn16yssqajtd3rDVmW4Bev2BkI5tJ4obGtouE7w0s/sNinZLMtg50WzuI6EFA
	 S0C30NaSYzDT75Fug2owyf0yeGsO5OoB5Ca/1iqlMerYaiP/KLXA7YcnyYzZVMQMW1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pH7C+Ic+skXIiL+8yDLrJvoIJ/Xi8EZtJUFQlV0QBE0=;
	b=vMHebYO3AgdMo3e2mFcihcZVudb04A+T/NoBLKTGNzmT3kg3B763ZVk86O3qx/xF9NjP
	 1joNdePvhZ+znSj+Fnic2yZtMM35UVDuFzcoR93hdTpc+DYwtpfSfDd9X5RXvOIiBMCcd
	 vJyJw37D+fFEav/68cYckvu9ezzSrjdRnEMqAtRI3s5FskoBeKAvEQrPpOHXpTFPWc9GF
	 8wurhKXofxcOG8B8TREBWmylLLJHVGmd3d6vd5IDo/uCI3LkB/54d1ykV0w3y3vA4MdwH
	 u9j/47bPuC6Q6TQ25/lYzN4RannX5IdHvCS3yma6LA8VUKAibxGqTX/ohdvELeqO/8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KW995WiV;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF7606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FF7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KW995WiV
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4322d310e7so122989666b.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757798; x=1793362598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pH7C+Ic+skXIiL+8yDLrJvoIJ/Xi8EZtJUFQlV0QBE0=;
        b=KW995WiV+2FKvyP/wgDtPTisweGN15FcNyMcGyClqJusS2poI0hz2xccJKOyCiI8Pv
         MqChXnM36N3LKhLeA3IZ0Xk4pnF8RWFkyj8Q69NAruevjjSaB2ttKASmsWper5vSfGhD
         Jz55nnvno4+UoxIFirw6wrTT0NMXfzI0L1sUd9/cmYHESFmkqHBm0sTPd/Sq9yEv7JC8
         8ZKUjFoprG35SN44ahrR4rNebW1k3645bCEZt+RAn4PufSpxNXeTdhzh32T8QTsaWlka
         twwdtrPXQaN7hhH/6wfANSkuq/zE28bvyJBU9X+tGSK0eSoVl7zYGk2/bhim0dny6MOx
         KiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757798; x=1793362598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pH7C+Ic+skXIiL+8yDLrJvoIJ/Xi8EZtJUFQlV0QBE0=;
        b=gaVyvZQlXdm5sL/Hw/wk9+jzoBITMOduXkrBptm7ZaUTnOwUiCwPf82EGAk8AlGJZ0
         8787h6Lw2xeojDSXHRISlbTwel31ms81cqDNx+SNGMFtLqXmTDcuYNvvJ4nxPp1McOP3
         HveXKMYXfO3naYeTiUqiuUE0VqVkLxPPCRcr7YS+y9EArpGNSThZ7oa8ToVTjhNgR+7q
         BPo+lI4mwtaxidrjzfl/re29A+2sF2HE64SbD/Y5buUc13dxL/t6HnO3Tw3jmfnwBZ+F
         jtAbIbQjA9P3sYjygmVCXQmxxIeUsnqyTSVcMqi56Nv0VfJ3C2XMpNvXtNUWyuSyv244
         6dqw==
X-Forwarded-Encrypted: i=1; AKwUvBxmXJPKf57b7RYnpRB5SEtCCMUU+2PtNKNuiySTJ76psB1Rrm4+DW62GU0J3WxAAWi9fVZmNng=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5TSCjnpvvh1MIbpy6OrtmC2LlzR+6BVr5pm9YmzPw3sD2h1Qe
	zUQgIG1JxlpIXB5Vbs+UVVpnO3dTz5doLm02EDhWsi3L51+wsQER1mQ4
X-Gm-Gg: AYBFou3D+gir1be3g4VgFK982bxaM30AanXsyZe4Rjoj0pJDWqhmD0lTTyl9ElUeYgE
	fOG3OufT3TwoVm9gRfYuVPNlvw7/2hLfSb/UZ6qRi0a8pD+LFUNSTMxySGAfzXOa+j0yUwq6hiP
	zAZmeioNCivswpunezZR6Mo2wDMSA/E/kbqR8rPWyJHcrsPTwg2um/yxxoX5oNbSofzQkWEQeRP
	7CUOErAuE8HM/fx6RBWuV1sMow99UG6vA3vj4t5V/RvQRrospeWKU0tLLVb90zwpbRQrXP6Gf6m
	4hlhkWmur4m9fBBVSHYB1iOW2J6cv/oAhIsFd4cKt2+BuvcIaQu6MxCXE4k7Mt8fgmS56SXz2WZ
	y+4xPfNkfyQ4BxA2OFkHvQQA645jIjkuxocR/n5GUBbPhDe4xNtjhK3qbNVCa7kc5HQpnlJX0TY
	brM4Aa85nG+3/D2hGhCSlE/Ay5APSlr7ldAVf/+qKEcNVP2ffZy2Izbm2nWQ3FvABmX4t3Sb2c0
	nXvVzYm0DbuLrdH40sbewmetqdH8hwqna6cUbYKXQlju2+01Q==
X-Received: by 2002:a17:907:9309:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c46a92d5849mr287640866b.48.1792757797774;
        Fri, 23 Oct 2026 05:16:37 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4f::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cf5540sm95824066b.78.2026.10.23.05.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:16:37 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Jinqian Yang <yangjinqian1@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Andrew Preece <apreece@meta.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Enable dynamic MSI-X allocation
Date: Fri, 23 Oct 2026 05:16:35 -0700
Message-ID: <20261023121635.2190639-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022193620.2152038-1-vlad.wing@gmail.com>
References: <20261022193620.2152038-1-vlad.wing@gmail.com>
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

Two updates on this report.

First, a correction: it is not specific to our debug config. Our
production config hits it as well, on every Grace + BCM57508 machine
we tried, at the same point in boot.

Second, the root cause is in bnxt_en, and this commit only exposes it.
When the channel count is raised, bnxt_check_rings() allocates the
extra MSI-X vectors before firmware has reserved them for the
function. On BCM57508, writes to MSI-X table entries beyond the
reserved IRQs don't stick, so the message written when the vectors
are activated is lost, and the entries stay zero after the
reservation.
x86 never notices because GENERIC_IRQ_RESERVATION_MODE makes the PCI
MSI domains MSI_FLAG_MUST_REACTIVATE and the message is written again
at request_irq() time. With this commit, arm64 GICv3 takes the same
dynamic path but writes the message only once, at allocation.

Instrumenting the driver showed it directly. After the channel count
went from 18 to 32, MSI-X entries 18-31 read back as all zero, while
the cached msi_msg and the ITS LPI mapping were correct. Exactly the
14 rings on those vectors lost their completions.

The fix is posted to netdev:

  https://lore.kernel.org/all/20261023121321.2127263-1-vlad.wing@gmail.com/

With it, the same machine runs cleanly through the channel change and
the ring resize. I don't think the ITS change needs to be reverted.

#regzbot monitor: https://lore.kernel.org/all/20261023121321.2127263-1-vlad.wing@gmail.com/

Thanks,
Vlad
