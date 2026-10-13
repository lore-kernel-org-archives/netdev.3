Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B74078C1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886912; cv=pass; b=gsFWlyGgT+gnzWNBw7tvbpQ5QyuQK+wZMBYkphOidYWhIY87kZ6TjUiu46yBcKuPLBL0QQXKcjOk5dtB84S+mHNmUJGL1N9vNnFCmgDLOpgruHnDii3zmFAIAp7NVu1oocuJzZkV/nJrDyzmrBXu95l+xV4feZ/hF7qGcP8VU7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886912; c=relaxed/simple;
	bh=kw30L9v26HRhBA7ngRHFl25NBDemgZ3UJ42WGs6r17k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjPSjCqXug2JdXpD460cBoz28xXS6kqtyh71ge4JdAnyYo3+NlQwYNvc2l95kXVPPSAXChuBxkYHapkCCc8a8UOQHvK9NbdAUQPCJOKl3BLVl65Akl2owTmbVKcte8qopMfjE7qUpkH3s4rCNGgIFh5kmmAQzIDotWZy+H6m0d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMb/PDFr; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMb/PDFr"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba3b1199f6so2401617e87.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791886909; cv=none;
        d=google.com; s=arc-20260327;
        b=Tzch7plqH4X6sFOw1nLp7VVB8xHcJxlOHOv+9qkNht2MpowG2FjtGyxoTfuLixf/0b
         NqMOOUL9l1UFcJ8fkdZO5SaPvPdxoteSKI2KxpBjPefwYvVJa6qPK5PXe3ItCCeDvCUV
         Gm4CSWRLNQYyhR7sLTAPKMjz9ullhD8V5+dtHlS/KrZ5jZRkIiFFtu8WdRrHtzRgz06i
         ZNA4Xlf1R/sTbelpu6vL1KIF9pbm0VZl4dn0QjoRkF2OGmyFekpfPVmAI4d0kbAYObpJ
         XtSuGoW/D8NmrQYnE41lmguEqiL8TyFJ8HsGzdy9foslydJXNhBCPiNn4JKOqweLuvJS
         S/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kw30L9v26HRhBA7ngRHFl25NBDemgZ3UJ42WGs6r17k=;
        fh=JiFQa+8smIVJdgy+/ZwGPs2xHemBcsKNbXtKt0cxlG8=;
        b=mIHegj3hf9DQYNzJOeVz+ei2QI16ktAwLtoenowKqdYUxITbvgtog+Np+EOMPj35oa
         viuzBs5OM97lL/Hfmd68axOxL+sMFNPvXjiqsSTa5jlkbIbTm2nVrWbF8gSoOet/Yge8
         tym3/2cv2XoSTJtlUtjPnZDmlDz4Nijv+L2UVRzyv9bANWqQ52QqF1d4h7/PkMNNERcs
         dtZDiPqZPMVccgHcrWxNe7nXQgwyp/cgVvtYIE2B4hCPOy4kZ/OJeIRLGCNVVRvOHIQX
         qmrPSysbDaP+/Rfuk5P4vrG/MD9egljjZH95vSw4dqqzvCrB3CHNMj3eiaL120hbi1Ut
         mz6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791886909; x=1792491709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kw30L9v26HRhBA7ngRHFl25NBDemgZ3UJ42WGs6r17k=;
        b=GMb/PDFrWoHJRy9pBHdTZo0/lj8Cg472bjve20axVR+DmIqGmLXL/J5FQr2lH0o+sk
         5nydQS0hHGSFh2Fixw7CV3fCrG9ZVkJGzEqLYfvS/LIdZ8DGZrSMGnRB3V0e5dQrb0tj
         GnKR8QJs/8IJhdGLSXgNcOPq/1dAUtyr/t//GhSGYxA62aGyTxtptqRuQaQizH6AhrAr
         kjX3vMYK3hx2QiF0x8qlGFTRSmXLHANPyVFQfkxR1QLP1iU/z1cZMX6f53hd6grXJFm4
         q7Pm2e2riBVfBSIWE8dgwbwNViO+K3MY2IsiG7XqfI2KUVZgdArq5OMNNUp5FmvsI6ky
         nUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886909; x=1792491709;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kw30L9v26HRhBA7ngRHFl25NBDemgZ3UJ42WGs6r17k=;
        b=DyCclknZn5TUg0U4VTcIWRtZBNt0yhx6lmlbAeO1b9n0LjaPihglMZnmW1Pn5BpkBY
         tgIcBUmB48avhtIUdolyW7D9w98keZ89FdsLNtL9MgLkdWzazAIO/yBlXJ7IG732YuD2
         NSeGZR/L6gxX2EHbyTX0abjTbIL8EwEQxt2vo8aOnIdxgqkUwB3DNwGFC6ZizTUpfdx9
         bZAGP+i8Z4AEvdZyZuZXnpqOHZTwZuYc6fFh/Yv6aGKfe5j2NnmKe6dZ4T2zIJViFr7S
         1RQUv5Q9WtAIa+K9KkMx3sEUqnWafthYUTAQ22KGKNTyITXVm+hTDZ6HjCpKxminNw8n
         2r7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwsE6MV+2geJhXIa7N1U23k9F3+6hsMDlLZVnGVuAAec78K8SsCzYJ7ArLDYfMXixTPXR4ZrVc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWQ9T5Q+/v6P8xvTif2aAMRWUa6aaCcONEaGee05a5VDa2gOWv
	w7ObHLgAt3SWJ6SjJzYnILHbq7oPU9P9ittrid+IUAYAn4g0udTqi5dYakRu3D0q8xiAzvUUKDO
	XbJ4e1i9zV9LZffv+xrgqHhZkXeZctvk=
X-Gm-Gg: AYBFou3jg7ml71IGueXEiBbl01MUjn96UY13T2pelxe3hEKmiqfPVAaXf9pYs+82qc+
	uHvHb0e2bQQhtiMEiw6dJNUqSoYeda1OAh7qZWmnYbNXD7gG9hrGuBDgWmQ7NzxK9TEEcsGvgsh
	/4+QC/UTR/1Blcm2U+cc2dtom5bE6lB08fA539QpBRbqQO4nMIrcgpOZOsPDWHF9eyia0HavHpc
	F7LmGfwQ1JqKerTSA9ViDT1w0hwGIfRKM/mhUsGJsCf5NGjNjU7cT6ctoX+XG97fhUt5mV+fvzM
	ZoQ+WpaBoTODTnoJWuveSaU7SB5JAf3ACv7uPGbij+taqhUISsde0oR3anx0p6DQ5zJxqJeVut6
	FCzzTfdzP5h8=
X-Received: by 2002:a05:6512:1302:b0:5b7:593c:244a with SMTP id
 2adb3069b0e04-5bcde6cb1b4mr4214429e87.44.1791886909214; Tue, 13 Oct 2026
 03:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012011707.3378-2-sigefriedhyy@gmail.com> <179185709784.434549.17899680533305071231@kernel.org>
In-Reply-To: <179185709784.434549.17899680533305071231@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 13 Oct 2026 19:21:38 +0900
X-Gm-Features: AclHuK9g3jw3wKxZcfUo-DjkbmbxBzgQ-U86o5Pm5ByOHON1wyGjQ9qc2fnRD5A
Message-ID: <CA+7S2v+LjXscrjWYE6kTu0uBR8co7G4xqXaHq30Za32rbg5FDg@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/6] netlink: specs: rt-addr: fix the type of target-netnsid
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Should this have a Fixes: tag?

Already discussed in previous thread.
