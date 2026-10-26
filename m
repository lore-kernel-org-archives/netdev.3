Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056375;
	b=3sSFtZ055uGUt/QA8SwXX6qqam8IgfgQEiBCGzHagGS8Raz1DRlXLTuplAg4bIEKm/OX
	 H771tUj2B2zDlKJSFugRu6aGZtFepkP+nUHL/1ij48DVeHJWrxmKhHMCuvI25chisbUOk
	 8RnMi2J/dQl0eGIN/t0UISWkgbkbeuOdsXmR27OLhQOHo3/MTeIL1SAh5D0Aw9gmuXAgI
	 aXIYeOCZQyhuuh2BN39USPROoL9oyfKjPBzRXEuZkwMSYStXgGkfAjwjHYDnGR/RIIBq8
	 xztfwwK4zSazeQTgFu+F3CrXclc9dKkG8LaFjDG5qIH976A1IZV4K+b8jLOlcTY639w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TLn7TVaVukXMVmZsUzU1TI29I6h9VPQT25Hl23f6vc8=;
	b=B41EJg7Q4YlsHbs8pAxpuEOp6+gESZE62LRXJJ+IOgLd85FJBJp/LXIGXIJ+7qerpZtj
	 NkkZMQdgCANObNet6tfhM3Wsaz1Brm5hCUks2SlQqSFUlpPNTxNGfDTvH3RgVv5G64Ozl
	 y4N5Hya1uQqm8C+Mlku5nAPfHFOiU13zLPmHopNrwpGYybYJwzAy+rp3Wd6UXraRZMz2b
	 AYfXfN91sdrCpjhVcD+k355kcz/nbm9tpiRqp/wHD2UJOp3rURDhs75buYKQcvzVNysP/
	 RUZ0pzKOZgrpe0h5ltQ3gkFGnVbeXC6RDgdgM4zJnsmGQyFmAWfaZNTdLYbwdmQg98w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aRilCere;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCF606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CCF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aRilCere
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso35998255e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793056373; x=1793661173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLn7TVaVukXMVmZsUzU1TI29I6h9VPQT25Hl23f6vc8=;
        b=aRilCerebHy+kF6vnnvW0jj/Q9uLDDrTywoyUyeMhiipONTZd2IUQluvjI0jnnKGNP
         5nppDehQuYJicLjntoH9W0d1gEvh5uvm+Y++H7Z/gm1g5FHCsSMqG6mFrDIOgDePHd38
         PqsapbD53k7pazaNKpc+I6MVV5O9Oj0+G3G21QQwXCkcFYjC1xE7ZAyOBZYcOGAa3MpX
         MMMkrR1ojHvLZD0LPu5JK6UmNI79ge7OFq8S2VE2LwsH/NQB8NHBRtG5hy6YpbY5aX4E
         k6JkCxilvej2FO2/anbmOpgOVrJx3N7Z0JiRMhgzbJq1cwNYOhT57VqQhUZ7vBjFgkvM
         E1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793056373; x=1793661173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLn7TVaVukXMVmZsUzU1TI29I6h9VPQT25Hl23f6vc8=;
        b=F93NqYq4JXlIjWzIiArdSAYAVpNnERqg1+jGnEocYnxHwRIY8SH5tpeL+J5HfpUDvH
         LFIEUU4AaD3aFaTq1w7Tg5yB2eY9hBKcpoSBuimRJcVw2S7oG90aUyRBQvOEvhNF7QQ5
         7mOHdCMkV4auv0uxpUV98GTe+IZaOMl1+ji71elDh7LY5tgMsdI2gKwRqBmWFfL7Z3xg
         KjfnxE2Ah6ySe/ehAbVkcW0cq4Zx3msElf5bvVOhSPgm9zCKppqSGP6MtYofw0qc/4In
         mKy3USwrslbrCiO0B7Hm7T5wuF0AyIyrMPBz8o8wPEiX2dMTG0cqXODGTfQrmsBkJ2Ir
         dBSA==
X-Forwarded-Encrypted: i=1; AKwUvBzGPsaF3FrdNm8XWZ1kh6Glmp9MLejJ7fIwvfyYmOyOgSaMed9jrBqccr5Zt6zpnze5owBKcIE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDPm415I2zbFNUOuHV490NHKOqn6aQZ3re6b6mAXdOYqVY3EIU
	PjEcI1IDeGDnEnKWwF7KhUtsoHG6B/ImWwXu17eWhN7HzRwtN5tnRi1vXyFErPbNjmE=
X-Gm-Gg: AYBFou0RGHBRKjeeTpLzG2mfa3yz9KUc+hMOzCkFGjH/sUBD871hBcT4r/pCDnYMeuk
	j/WGK0Ebex6ir/ANeYrKHTkMLUIj9n4SGtaZI3F1kks/EWO3z6x/hHSlSu4ow5jv8DUu2p2JNZr
	NrNHCfimQ6awABlIBjQfo1PQHObu1BWKZEuevyo+MKTT0wFnuLzqu4RD3hX+3+2KKsVBXvThncw
	erg+D9cfIgCIb1DA7Ubsg2Nuwy8bOV+P0Mt1a8qRY5FT/OgVZuf1Yp6xvPcG8h0zS/UbZ2SCUsV
	Q9KTHrNKJvbrWbAdoyFMX4+iSO87cPPJjPwaCGpHcCku2xFM2J48Z8jiJbPUThmOAW2aOqsL6vH
	hwimu8IM05jLJkRccehAic0VAkLNbwY8gy2RoHdijuSH8niNYEmLdlJkX0DTTJ9Or+3Zku37R0o
	y04GQz0zdDhHLrb2tikFiDfjjDOaZwcdCj+CirHpQy4Hna5NTjBlAiYrCz6JDik2MvM+4ezjMiN
	j25X3IV1bTiXIBp687KCLmmFxT8E/BL0XmiWJbKTZ5tLVQB0TTGyni2Sei1NWWrRAdvP9ky6BIl
	JGk83LZkpoB7QjJIHFnJcK2fIOtVewRKX3XSWaf/vDWPCqJ8P8A35lJIkW9+UQ==
X-Received: by 2002:a05:600c:840e:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a35acafc84mr143906785e9.10.1793056373131;
        Mon, 26 Oct 2026 16:12:53 -0700 (PDT)
Received: from iamyoubutArch.adf.bham.ac.uk (smal-20-b2-v4wan-173097-cust1152.vm20.cable.virginm.net. [77.97.36.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm212047515e9.9.2026.10.26.16.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:12:52 -0700 (PDT)
From: Filippo Falezza <effeffe99@gmail.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: Filippo Falezza <effeffe99@gmail.com>,
	mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Mon, 26 Oct 2026 23:12:36 +0000
Message-ID: <20261026231243.68801-1-effeffe99@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022163116.1042-1-26rote@gmail.com>
References: <20261022163116.1042-1-26rote@gmail.com>
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

Hello Joonhoe,

I ran into the same problem on a Motorola Moto G 5G Plus (SM7250),
which I'm bringing up on linux-next (next-20261021). Since the HELLO
gate went in, the name service's first announcement to the modem fails
with -EAGAIN on every boot, and so far I had been carrying a local
retry loop in ns.c to get rmtfs announced to it.

I dropped that loop, applied your v2 instead, and booted the phone
seven times in a row. The modem came up and registered on the network
on every boot, with rmtfs serving it, and the phone never reset.
"failed to announce new service" still shows up once for a remote
whose HELLO arrives before ours (one boot logged it for both the ADSP
and the modem, others once or not at all), and the modem carries on
normally afterwards, which matches the replay doing its job.

One thing I couldn't cover is a modem restart: on this phone it
resets the whole SoC with or without your patch, so that's a separate
problem here and says nothing about the patch.

I did the testing with the help of an AI coding assistant (Claude Code);
the results above are from the phone.

Tested-by: Filippo Falezza <effeffe99@gmail.com> # Motorola Moto G 5G Plus nairo (SM7250)

Thanks,
Filippo
