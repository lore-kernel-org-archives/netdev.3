Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48A480321
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805495; cv=pass; b=Y8Qw3b136q0Pp2+/1WMZ+vW8QSTQ0FfiRYYzhV7a9WwHw9sscR3bFCM25CAaeJ9o/1kIYZwt+GjOI7N3AXUZxo5KbVPTRx8a3AAeb6RwNHuWn2+3ZtWVHMmoVNxSXW4goqUyMg1MIoWWCHU0QvUwDkt0l4eifWIo5KZci+psUrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805495; c=relaxed/simple;
	bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzWTlqh/9O5cGMtmwXXvquGI8e7uhz52ikMn0HfDoY8wJhjIUofdFCFJVWEusPZndPTniK1S5Xi5RFvVwK6kCdli8CQwhVQrejkk/ZGip1e9FcOE3Hpr0w0BPHEDrxeKSwL9lyDvlscSoVbdwLxzyb2RK+QGBEbHVecd+4Gyg0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=IEFSVWtm; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="IEFSVWtm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db710396ffso22608675ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791805485; cv=none;
        d=google.com; s=arc-20260327;
        b=R+qSknokDnQRbSbIPX0J9RLXdCe7jvnbDOvvczCr0VvZyfzBhfCtqJwlT56fsoptbp
         HqPc/kS96P3W5rlPXu2hnWiSJN40oG6nqx2eoeEau8jwxSsmDyWRP0sQiZ9CgmmDp/9S
         yyKfPmOsFhG+LJj30fwSvLe3D5jEFX5K2k/i3Phw1w98H4alxdPKblQWgv/ysubE5Tar
         OeSUY/PVAtlXAc8eZpKLRUGJXAW/hvN7647gSKOv8j+fRQ9ByoVdfjNBzkOACD/PkHOO
         sZgKETuvJGLBMoXb92PteFQ8dOM5HLTCWcNJyUiaSAPvNuQGacP3GgLtuC7L+MtpqZyU
         zG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
        fh=o35q+2TjwVXYQojqSks8RlSKI1dtZyJHiTn/u4Lanbg=;
        b=OIairtv13byGfkkdPGx6ODBfRGlymNwRi6nQyG8fTHrMLrp4l1YSmiEYqY8D/hmE3k
         6/Rern4HDJMnvSfBGD8e3HDHw2C8dYqN4rz4yxZ7Ak1fPfXBylpZw46nnTcxOaWw2vlX
         EOFUx8MrtlnbvXWHtcWFFhgmz22bybBaQCAJxwZbhk4uVtrYgvRDaFPFXdFHXoq1vqIF
         zPOAVbjTfRg6AFnv5wliyDnfXmm93nsnY4sr0StQqQ6kouz6mssrItEvprvYtQKW7Nsr
         qUpOJjvAgb9L4RXGCB9yE9fQrVoLSgoFJkX+ttDQuaOCMCo3SmOc4EM8nLFmnbw+mdq2
         5JBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791805485; x=1792410285; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
        b=IEFSVWtmlNm2VN1Z/jBh3oV+qIqPPNXMWDBMjPPefkt5SKaFOjoLtiRE0oxh9hyfSA
         LUu7LIU4nNJsim9yIkhJWLH0GKg7l5X1+YFuYh5F4RjS/Xm67IsBBFMQqnZ7tbgjwuk5
         5CfNQq2Yvf5F575ke1gylG3lXSTqvsQboFW4x7vjLtzf1aa80u85zXVv5MOxNXWckjtO
         dailra+8edkDAbBTU6xe+9JsEGH7Odx5G7ApbxuUqx+1bYdIml8Szvv+4JrZ6gWKw2oa
         dWFkxeDSoVXzUanVj3Lo1FBwwRYhRMVx4xWyETxmELlLuSBXyaVhg9r1yVsM6gBJ0jzD
         9x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805485; x=1792410285;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K6a+uG2V+IR5Io6i+GqIRtQTxPtGAXil8uNEAa2cL8k=;
        b=2rMnOa0QJ9RwtKYNzM6RR3RBCU4K8gK1O3FxEC5ZY7FoqvRKSjfmKlwxoKs3qmfaYc
         qkXcckhXPYk3Wa65OMEIhYnc7yLGtJ6ll4pT+MhNAPmM5Ryl0Kv+idqgSKaWkKyb7YZ8
         1AQko0DK8ltAcvb02Tt1hk3nX32wR90b2SakDMcVmwone82O+U/LOkduRzEjQ7ukHpLY
         Wlcnp5rAGI7MmeEw+qfue2jYDuhxFJwO9UMI9L+qBjWiJEvnPuQGY4QIsalxK2guT1yW
         EBHDZ+xtlad2SgQa2QnWAoDzVfif27hiN5qIaLBvXALHmmFTLgwQdbxHK42Rh15bq+R0
         5XHw==
X-Gm-Message-State: AFq9FYKucy2iHihzilzlmCvSL8SUdopplMMZbX0I/KyEOcLYS2yX8CjX
	gyYX2TrbImoPTVljqoy9gXzTo9UEHWaiYzKdH/VpsEw4Orj2tf8fFY70QNjrZkI/A2xPVpSzJY0
	4Qni8XeM55g3t05D+WikzQF6SCcRw7GfBYWbO98mWWw==
X-Gm-Gg: AYBFou0ENjRyMO5DeZGz7Av5cOYFxCiX8iRCyW+bHWmk4euxYT208n82jofo9PcrfCg
	rR+dUGbD7OiFcjwkxpInwzsVBvEjyJe+nNn699XN7dqGTr6m7IrZybYD1W+lakkJuCwhAz0GMEm
	o1fT9rh2TzQxCZASytw2t3EAB5W8fke+2ukFrCYbke9a0V5jweuBhY3jZbOcTflu+Zhxmx9PvOc
	gJSz0EsraxJH5ojxlRA1+oL8495T9WMUs0t8J3ZgEi3o64YN7O3HKWl99g9DuFJX4tHYf4m0Ugg
	8SCZewJyeOXG6wus5ntjekt3RIzPdyZTbTXgxY9aks/PTpl3KwhoQzCHbd9f548RsEEbrpeHitx
	FnranEMZiheEbuNimpOiVg1RD1xVbuLySN7Mkh97pu6iJjZUyJBUO25qrnSa2bTA4k1HGCykah2
	k=
X-Received: by 2002:a17:903:3885:b0:2e7:ff36:c4d1 with SMTP id
 d9443c01a7336-2e840517a80mr65819775ad.31.1791805485551; Mon, 12 Oct 2026
 04:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
In-Reply-To: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Mon, 12 Oct 2026 13:44:19 +0200
X-Gm-Features: AclHuK9deDiVZ9f5xu6gGTRgmzdiz6FT9YboEHc7TBFHIaXDKq-IUEmQQbcQAvY
Message-ID: <CAPa5EdD7tFRyDztEanTwQXTzVEE8T0FLkbXAtWxUcGGaLYt_bA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nic_swsd@realtek.com, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

To keep the reports at a single place, the bug affects not only r8169,
but apparently some r8152 USB cards as well, as reported in [1].

I had this one (0bda:8153) lying around, so I will conduct the testing
of the patches with that.

[1] https://github.com/home-assistant/operating-system/issues/5019#issuecomment-6111103634

Regards,
Jan
