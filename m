Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723114D2EFE
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784426; cv=pass; b=Avj9CVqSPFjmtOZlTN7S4mrelWbVRqgxeFOgZPCelD+klE/ag3DRxyfN5Ye6s5CcaG/MdZ2vr0/LMtPb90nmefX4LqDGk2ts4a+qR6vY1EomHuYa8ReMQCQuDrgcrWYr0+6aoovqnp1JCPUOBHtWmuQTBl86fl8f/lXETCfxLoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784426; c=relaxed/simple;
	bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEl+R3c0BLkZ7F9h4IaMFLnRBtrX7ATRCxhr3TTVXqpbNww+mpjSjcU4Q/SIzeq9d2vLvL6ErSicUWmkplJ+o22gXf3d4g3Y/07g2iZriDJ4KPYR8iVzDAIFY9/6VUF4XjI9fDJz7iRtJXGrQlMaprR8k1dG4wDcphKYmNsCwis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3e6jQTp; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3e6jQTp"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a76a5a5d4cso16006251fa.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784420; cv=none;
        d=google.com; s=arc-20260327;
        b=XwzqgVd9qIXNyQFzFzQUlOHhKwQjWMXmBliPuSt6LTZBcGpKrFb0ud0guxM5s4cHlw
         A6qz48sB9zd1fTalhyTP0T3I1hlf852oRaWo7GmqK+w1X3M1xl8I45bwQ7q3tJClx6oD
         +WArJ6EZXNZDY5ubiD/Q8kkBnEttW/yPdXDdjc+FR4HBlTv2yBZdq3lnfjRVssMNO9kQ
         jiE/AsdYX/OJ7YklZkEyft+ES/BqXDjExLRmvb4T1JYb6Ud0c5R/MKO6tdxeEXL3ehXB
         pHaNvPKSbxc8zyxja8n9q+NO836rx5cjRKRDONz6yOYrbBlrz+4IQChbc/8OowqA3Ree
         UnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
        fh=9MODGmwqQXiu51e72eTpOkTvDOXW7k1cS4lho4NmORA=;
        b=IY79TFW5G6gQMGrA3eMxzzBfxifAbt9RZrh1VjA5jrN1scxxaRVDcoF0Iu2ysK7u4a
         sBp0z0qofI0dNmaImSOX17YcstacqOR0tMSkB6jvWmR+e8ua6hkHeWFilq8nzTLLhhKV
         y/CdT68dphmKicCylerFyBi8Y05lWbYXDOo2PC9axxZDVEhyClCXgxYuWlXT+uRai2oT
         11n3+agXoRMEXwvuB3SjLi5zZNy34dpaGege7H+tqBGMpNXLhFAxkeZ97cntDS0AEhJ5
         8qwdzHvmZ4uFeqK1CjBgMxzlE1LglPi/q549fWDv6x/PLFxJ+n0S67D4Iepq+a7EphI/
         2LEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790784420; x=1791389220; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
        b=i3e6jQTpk9MFny+zRI9ShvLMAzlRUcpA+oB6Rj/87c6z/Ycuj/O3hBMFm6AhN4VmEe
         Ap72V6o6OUVJwerxwdxyCltDppotx2h3NY9WaFRWSiTxltHj3swblyxki/CFv0E6+l2H
         mgQ8SERM/Ew7RixtLQoT2tPKuiEHjoeX8cjankMgp5mlR3CpuHYsvcKE2Mcu2A3NS9fH
         itaOBK/7LH2PYR4bqiE8D+oPoZvstewlKtayfZT/CM+XTB0TWUOR+dpnzNWLPNHdZ/tv
         ROU1Vhb+k49BrY/fDs170g4kw+peWKckXMLD30kqXWeRHy2KylhmIogDRH/WoMg4HabO
         5z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784420; x=1791389220;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mr1y+u1OF3mjJvkZyDof7OV8WyZGPL7d/VHEFCAfkdI=;
        b=v7SPL8wgDGH2ktlbhhXnQWFVJrt4ygKOvy/zJ2QS42FNy0ozYjfMtwA3pW5jDqc79a
         BnUEWBy8qzMqVSmeU98+pJwwOyXGgsElVfDVWBG/CFh2Uh3rGBPu7i9h+rgBBAPzjjAL
         UU4Z9vtgd0EoILP/FTtS4lPkGrUjmqhroZn7OomtpySQWktzI/cveX0Aehdoy6GJ+bhh
         BtEIKT86JtSI/d2hd8flvC+IJrN+q6xJqzcO3Ntzv1HhAX8vmHFF+EmCXeQ15iWpzRMV
         wZaY4/NrVPqyYlNgEz8dRJ2zstZDsWr4jU2ZnvV0gaQ4ZcOR8gq6jo9zlEY6dqgm+amW
         +2Vg==
X-Forwarded-Encrypted: i=1; AKwUvBy4W5JHKzmviT2+LK9fbYGJTX8k7CciyKkQU8ktZ4y6KOMzV8oVkR/yp3Vokxw8hanBITxg0yk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKAbqx+keZx9fAf5ZuZAVIFJ03R2On4T1L3wzPfsbWkLMrHbjQ
	2bN/uv090+r6Rsvok8gmOobXH38FhQKtUPSDW8JRbdKvM4zg8CX8Jw8HHiWv+6ZBOo0oWv3Z4Qv
	QtgiHSLvtqjish0EhUP0fmwwJ5VhjNyU=
X-Gm-Gg: AYBFou1kBWafv8py8QMpY85/Hf5i4uQZwuvFFnXNL3d+DB/tecG1Vh1NFh+VVB9DZgc
	l7u2k0M6VhKf/G9pqFGdA2a+rroA6+pF7k8YO9ZEcxZXICtUMaU98JS85lXorcnyH0rq43gRktB
	BI/prJWzi0JAfvW4VyK1bPicths/UrcmQY2z/4fZpw5L5/7asT/G3IYQE+4XInYNQRNPYNI2ulI
	cy2RiT68HJdviLbDM8d6Wlv0aFd5rJimMZB3SfMnNysC/fC5ttgszVp2m9l9g9wArOj9LICXoK/
	1yMRpLR9kSmwN7PbqbAWwQyNTqPXBlFmRBLt/i3DX7v5rBi+urr1ybZXkg==
X-Received: by 2002:a2e:ae07:0:b0:3a7:6d4a:1c9e with SMTP id
 38308e7fff4ca-3a77920702bmr5335761fa.11.1790784419801; Wed, 30 Sep 2026
 09:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923234819.702327-1-oss.patchbox@gmail.com> <20260928091551.GK13925@horms.kernel.org>
In-Reply-To: <20260928091551.GK13925@horms.kernel.org>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Wed, 30 Sep 2026 12:06:48 -0400
X-Gm-Features: AclHuK_HJEwr8rDcX7-6pNmp93VhndPAHBA6EzKYzl5-IOAv0A5_y9agapxl7BU
Message-ID: <CAGG=RgBNpQLy3s7Zqf1=TpN_grUOha8Cu_UVmjou=qPe0RBqiw@mail.gmail.com>
Subject: Re: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I appreciate your time to review this.

On Mon, 28 Sept 2026 at 05:15, Simon Horman <horms@kernel.org> wrote:
>
> > Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
>
> I don't believe that commit introduced this problem.

Thanks for catching this. I'll fix this tag.

> name is allocated by kasprintf() which is a wrapper around kvasprintf_const().
> And kvasprintf_const() documents that it's return value should be freed
> using kfree_const(). I don't think it will make any run-time difference
> here, but perhaps it would be best to follow that convention.

kasprintf() uses kvasprintf(), not kvasprintf_const(), so the name is
always kmalloc'ed and kfree() matches the kfree(free_irq()) used on the
normal path. Please correct me if I'm wrong.

> Also, for completeness, shouldn't there be error handling for the case
> where the allocation of name fails?
>

Agreed, I'll add it in v2
