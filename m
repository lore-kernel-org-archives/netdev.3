Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1872135B8
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290334; cv=none; b=YI5ThSR0PdNWxS9As/kTB5KHgdPj0CKbxRr0s3MQwgvkFqFI5r8Mk4gcUTlON8rpIinOTJJDLfnQpU6JwMGi0RFlkuj0GkQCL7Lh+6dyEKs6THB8iy5bqrtqoq8mG+gufZRTcMOb5OliTkf/fP6JRCGj0vVor5J3iDSaRVAeJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290334; c=relaxed/simple;
	bh=cOWgL4Y5aOSoL3opS9VqD9bwE2Ik8UunaS8+RLwbmv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IghhErVbBmJ8FnRGa9VbMxfb0dDI63rkmtEO4vTdDiuxrv0u0gJJBMoBc+AJycUrER3QszMOVisS1cVlsBFmpwNpE8MsVhFL/dzjAg50xnANBSAsyKCK3AAjiB5kHMESvLoNPJMBqck3gJogZtVNQQZaRxnP7NVQek53OV5eOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=sJbwSk21; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="sJbwSk21"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso1597644a12.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792290332; x=1792895132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOWgL4Y5aOSoL3opS9VqD9bwE2Ik8UunaS8+RLwbmv0=;
        b=sJbwSk2180ZFZkpasPbMUs+VnMuDmisi/Ml/uMIqWgJu+Wy2c8tk0IPP8f1gNewA+9
         7j4qFEMLErx/AMNezdDNt1ya079p74pP1J2G07FVj4DcMBu3XwhRcP/KVRuQY9N/X8zI
         g3QUPlvDmAud0UDDID/3PKF3hyiMlNaFURBHy6HaQCah7yvngWZbyE8FWAZOz2EIZ6im
         4Ztw1lG2LyAbP/lJW1CMRQa/j1l0sWkuM+ufTN7wTzXQoxvLfe7no1E6s+oAoor7hb48
         dwwcD7adG3cEge0Ghw7bGupo+mxFmjjgLJHC5r5QdV9kGaSUvM0u0sObg0arJdHDXXcD
         VfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792290332; x=1792895132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cOWgL4Y5aOSoL3opS9VqD9bwE2Ik8UunaS8+RLwbmv0=;
        b=pJGViDQ1pNznP8cYBrWYP+Ku/u8q8Gki6LtodFUS0TJoNVuFFAvPSchewhmTql09qQ
         4s7vHp4x5JL3xpLf59Qthd4ibastO0v6QoPzFc6O0J6aZgF22y2IuBfLSAxSLqzimdjD
         vDektVNNxeOBCI1Ze9i/MHOYY0kcU35FdT2nu8ePZycNvWmwXvFbF8zmoCnyN8DbDbkE
         5ajh6/3Jas93+HFfNL85jsWa7bj4V0kppq+j1s42lm46vyboSNLQewQsXwMAGb033ZGc
         +jBSAvSV9S1BglPVCTFOtzEfl6Y38icXMOkYkotkCTiXaxpQDwVh++Pfw4IC/b5B3hAW
         ti7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzOnEmTc+deLesweKCijhnqzoelKE2OiC167QYnsoHN3/2RXYjXBCk0dJb/limaE9M834w6Ze4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1oRarajAh3kJsEVGZov5vA7aAq9Mt8FRGAtvcCP+iJ/zeR5AP
	c3if3gXH76dS2L5YSK0fVlAecEWKT8vx/dEfsJ/W2EKGi4c3gyidHu7T5h26k+8qfw==
X-Gm-Gg: AYBFou3HqD/GWrNDtA+MFkmiNc7tg2PU0nDbqD0I6rRcMrSqowddXLs9dXeGEL5UEsT
	eV/YLlG+HRo6S8uZCZVEBhw14yc/robPczSF9VpGouqzV5dqpPXXoh7JBxelIDq62biMAKxVUb8
	1JChAN05d1LJLpjnLmXhMvqBD1s4KoH7X+Jofe5OasWiJQ+AGXOh1xO1GsFgE4VMPAttrzaTna1
	4BxS8Hgmf+rIn70fjjjN3+rsMyD8gn/Fwl/l/LpJcwhpwcAIbpbdIm2ysc4mBQDxwXG5VpUgHl2
	rvc+tFOimG+VOLkgJNSHxR0vepBkxpRSHIAb8lD6d866GKeJbKT/rGzRM5IHoXEnuChwtc2NdoX
	xISr11wbHavnuEiuH3KSeYphzdhWcrGN1Gy2muLkHxqV6CKgj7e0rYeXwJV5KEcFjGuHXh62/HO
	a+hMoxLrIivdPsiWIArDVrqQUTkcvie3rhfElXxrhujUWgBzFpLQ9OcR4xYhKvsWkArnXI+I3BT
	rorqsaj7rOZPbEEuGTLsNOnamhACk2OBZZB3k35lYOtzkM8+IGM4PSzZIzehDUo/87E4WWz8b8b
	l3zfverx2MVhChWOG+rlbJNbvwzi6CAlTHyrFYnuJm+gzzCv9w/pzLN+gwfDau1kWuSejIu9MhD
	DrdelsHowShSFIW/Mp0Y6JDpSNVehkJI4hu8HX3m16CxtLi4d6KWFg1vk4mDdBdAD/tubPjw0TW
	fagfVMoZa/NrumStrED1VKTz6UTNqcxDFDgRrFkAgLsam7uQPpk71p2CcwIYurpw==
X-Received: by 2002:a17:907:e849:b0:c40:4320:de2c with SMTP id a640c23a62f3a-c419e73e2a1mr277700866b.15.1792290331870;
        Sat, 17 Oct 2026 19:25:31 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f247429d100000000000000a27.dip0.t-ipconnect.de. [2003:f2:4742:9d10::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c4c5dsm222994366b.39.2026.10.17.19.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:25:30 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: jianbol@nvidia.com
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v3 1/3] net/mlx5e: Ignore FLOW_ACTION_PRIORITY on flowtable offload
Date: Sun, 18 Oct 2026 04:25:27 +0200
Message-ID: <20261018022527.4065122-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAC1t37K0tEMzxmRhLeHnH-TPx61pZmCHt0xxTJ5Wq2Wxvzv8Jw@mail.gmail.com>
References: <CAC1t37K0tEMzxmRhLeHnH-TPx61pZmCHt0xxTJ5Wq2Wxvzv8Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jianbo,

v4 is ready with your Reviewed-by on 1/3, the rename to
skbedit_prio.c and the consequence line. Pablo asked to handle one
series at a time, so I will post it once the fdb roaming series is
merged.

Thanks,
Julius
