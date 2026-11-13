Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603390;
	b=FDhYmTTWkSllJZomP6J1wyP+lWfr3/UIk5huAlzgu/aQNezpABMOtomSqRL0WYlUagO4
	 bUzUCqfEkdj/8IkVRPaX6oGrAbxpKjKaKNJShS573fCq//7hdjIhoJ556DFb3ShfDwmbH
	 GMO74lycQXMVo3DM7amsfVFh+44Ck8bWnhrP2jWzUzA3VxLE75raH5VuCIyE2p+ZACwB3
	 Bd1d4f3lL7C6/IxEGMZ/OQf74I+mABsxXHXBELaCR/TOutu+b68sGGk+HUn3YuDjsVYN9
	 tYU/Zq2MLMG8Q7EdtR/azlLhrV9zjnZ5KHXG0qCYoJ8yZ21ljMt5ZBQ9sPQBdfJHssg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
	b=lB8IC/WEN6r8v5t3UHoQkopDPnk9FigQLvZA8HJ6V8zCneesabVx4NNtojYpn8Job+pn
	 1Skd7r7ueX/C8P00wO+tEr+JXrsbpfdjVzlryffXsCYMyn6ubkvaa/BK7kg5nrlrFl6Lm
	 dplr94My6flEuDdD5OWbNsAvf3HbWEWSQpXRQod2FpRfRfW4ssnAWbDpWTevO1euHpEMO
	 XFaTHSbQqgaTx6NbC3qTCmXzg+er5ulIi2di7q8A/ftyP2bcgNRO1pwf8xoy/eIVEa9gk
	 OS8FaVIU03c5vMpMx7KBUajPYKGJ7cYnTlNu+bopmWHiYHWr/0BnTxu9h3eO99dlTuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCln0kLE;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68E606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D68E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCln0kLE
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so19545255e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794603388; x=1795208188; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
        b=CCln0kLEhSJ5z/Gv6ubHO3pZCbefSWHsaYX8/0cV9VWC9X1FC5faPbwwUCuN14LhRk
         zE6u05S+Frwgj0owddD/YG0SHivRXsEvfcRl24hnawrRKapgFFlPpHPLO2zTsfT8BiE+
         /f0lpZje+DIN68Aaf+eEAiUyy+6TH9Uc1BoGNRICQZ8SbrSRhlf++YcAMxvC2wtXwVDd
         fqsc1E83i+xZu5IdTU5D2ZasR3EfHAtr8EfxlRnb8twcyY1tE4la0hwu09EkmF/RKUUJ
         OzOuk5ft8wKUMyQW2AII43cP81LJoSYQ9zvByT+Jsaw2bAbnFuj/wwXnkJbS/fQzcpQg
         Berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794603388; x=1795208188;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAX2A50EYtJkcTfS6TxnLukDj/BxU0JA6j0fOn1wRUc=;
        b=jUxm9mS4kEcqj5ex7O6rF2/0+IbiJkm6gcFHWALh3h+Dj49HWCSPXh6h99anz9/BnC
         hBOxRjUFBA8teLxU4N7jA2j8wWZD2CWGaae5Yv3xZmYYSCnDzB/MBHmCtUOK6+Qre2wF
         ku8RUMgeUambE9gg2ff9siwKX4fXSkhTho54npxgmBOCNmElLpWhKvDkoAn9uED2CQ+Y
         rTAhzxEuPp54M16UrPCKX+IG2MqPAd3NEGR7Zxdiv5BbEqgOf8O3laEXNXARqzxpNRlZ
         C5FuGNenAFufQC/lOzgf8wQy6inJY4+1jMTIVhZvM+DBqkeJdi2uut/NyMkksEBuhGs1
         dcoA==
X-Forwarded-Encrypted: i=1; AL+hErECZzHr6bzbgEv5xF+vuJbicwVUM6NUMNwJR7/fnTXj0iYSc6BfHBbf6a71mCQXZgWmSH/4duw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DkSjXOVypslzvicsHj28Hqs4yxwVJSI5Xzsksw7485vPE3Ohh
	3k4sSNCh5i0/PffFcyPH/mFkeLjwKBfRIgmoonxWhqZnwMw7WX0jWf0=
X-Gm-Gg: AYBFou3cWMWHJkroXKaPdJY+AW+4OZ5tbvJPTsPh/CdPc2LBiStbuW2sCxIsK1t8Gdg
	FKm7Lb8sVeMbXUCWACPi4BG3AH9fS1PDIYFcMfs5kudOj/t3m/Bhc1qWaNNGswRtUFiRoRQvWcU
	V1NKtYeZDugsySrEYokOILk28yU6iaW2BplxEi/ecAPpRhSQuwCS+QP1FzA0ulHpa4EEb67HRT5
	gCH13nZxlRiR2QO8Bxo2UG/9aCFMSM521j47Y3Nx415vrKqt86oa04nDYQxc0i4zYxZX/GHCooR
	v+jkmD5eyxR3BicQYndyQFIjWhUbNj4rZNJvd5ejLaon08v7r5RUWAjFbVs4YenYjPsM7iImXSz
	NU5+XI9CoJo6fg0FOl3yg/yPJDEfwghbP5AWAAnLeKIn0pC8eQbtObt/77dGYzCHnMw4DWEdmUk
	NEl+/oVWO7rCgsqXG5y040a+v+iNnGbuBbM0+mEHh63SMvf6zOHNfIIr6CevO6XmTalgUZIWgB6
	gRnnLZ29vlWZjwh9DNkrP5bQR09OU3EDVr/8Vfl3Qpw0DkwdLBCmlyweBi4jSNXIt17M+4=
X-Received: by 2002:a05:600c:e557:10b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb55a4498amr53684645e9.7.1794603387760;
        Fri, 13 Nov 2026 12:56:27 -0800 (PST)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f77fc47sm7529816f8f.22.2026.11.13.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:56:27 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, brauner@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH nf 0/5] netfilter: pin file with get_file_rcu() before
 reading f_cred
Date: Fri, 13 Nov 2026 20:56:26 -0000
Message-ID: <179460338684.2413387.5393789134820648556@gmail.com>
In-Reply-To: <179193541159.160550.12220807019134258858@kernel.org>
References: <20261013234329.2797868-1-tristmd@gmail.com>
 <179193541159.160550.12220807019134258858@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

These were found by manual code inspection. After commit 0ede61d8589cc
("file: convert to SLAB_TYPESAFE_BY_RCU"), I audited callers that read
file->f_cred under RCU without pinning the file with get_file_rcu().

The issue has not been triggered in practice. It is a theoretical race
where a struct file slab slot is freed and reused while netfilter code
still reads f_cred through the old pointer, but the race window is
narrow (a few loads in softirq context).

The same bug class was independently confirmed and fixed in eventpoll
(commits a10fbbe74e1c7, 0d8cd9537c641 in v7.3), which validates that
SLAB_TYPESAFE_BY_RCU file reuse is a real concern for unpinned readers.

Thanks,
Tristan
