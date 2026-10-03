Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4B384CDA
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791049199; cv=pass; b=GygdHXuaKzaQpVgheWlk06bag/D8C/aipcrp+vOlVd70K7F3ekfgwkTbnsbVhcobhM7DnYt+t6YpOmfGyYZ5UblyPjEwrjos6shR3EmQvxiUb+2mvj/aqxoun5HfXKt/YGPUnzBsLcAaUG41x9oWc3FqIgOd0s9u+qXGS0bSvyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791049199; c=relaxed/simple;
	bh=TIM/FkEd2LW4QIqIhswYwuTQuctqLS5573zsCgz2EZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7WvcSclcQUvXHN/atujxVkT2TCvrgW27+9q75R9p2VK/CTBvB07pA3hE4fyd44ncnzYVRUoexgEA6jSmgC+JRn1pqtpHIM7wAQMah3Q5TEqIrhp754HfhYMyLx1r4+MG9mdZJqLdE2800Ip3zQbrTYTQCeUu5XX1LZxNcIWpiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbWLHtDf; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbWLHtDf"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35120d43ecaso220656eec.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791049197; cv=none;
        d=google.com; s=arc-20260327;
        b=iBocS/gfN/zY3Ho4UxkzzMebmZe/nKz2ylygXIm/QbKQrFgscFWsRSi+yw07fpFsIi
         oHMWZcmUD5Re6sAXTinnN6t2FqGkezTb3yjLhB/OKAKatpGbnZSYqFDjXngNJoG43B6D
         2bLlZXDq8P9p3shZhzGjS0zJS21Q/mCr0YeSPfSOfX8jEDr98N6buKwP6yxTeaF9lNcL
         XGCD9+QE+22TL2tD28IY8apPPD+t/8AQNNTrbp3xuLc6YKHN8ZJ+Xlakh0KO6QFD5DAP
         YebxnuJ3kfx/Be0Fr2FdYYTxLSJWKATp8HcqapO2rVGwhDnuSs0PYFhWA13L/v08QVRo
         ObUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFnqgsSeoGHR1ZREgHRbdn6RIhZcMzx0GUNeyE+fwl4=;
        fh=DrYoKgxBsQceAknBTc1iZo7XbBp7cZkWIAUfxZlps3M=;
        b=UjaNKNROSNSztX94VbIBexz6crKpy2WLH28qUm1lwJpMOilt2Su3JVUqt0w995pdC3
         K5VCMd68+efT3KIUTdTcdR19U9sQ8e/4uUaejImM5fDOb7seNjdCVue+FV3q0fy7HLE/
         uWs8L1feCDTnpM2HQ1YgmdZBasarfURdSiUNWFu9gEvd4gAn247A0W3NiGHrlHWH6Wj3
         FCah2HYept9rD75RtaLk6Ggk2j+sL5RiXtUvLzSMJJcFnmgn2UtI3MVqLBcSGdp/0BiJ
         uTG9xqsHf7rL+ZT75ldYPcU0cdZk6SFGsghw1mPbbpP/CW8R+jlCEyihQ+p/oeM9vYRo
         xLyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791049197; x=1791653997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lFnqgsSeoGHR1ZREgHRbdn6RIhZcMzx0GUNeyE+fwl4=;
        b=JbWLHtDfnuXb1JPhF39zfG3+V4Fn4LyDKY+GjZFm1ziAaZEutSOMowd+gtGYSEPTgq
         SXg43U2/kcB1Wz3u/MMdT0M0DWbHS3rIfgQ/6zgmvfzYDklWJQLtmQRZLWI/MMWYoZw0
         1+/163VClgeXNugLjr8AkztrGrjXgWyxv+YlfWUS6ui/c0ldoM6ysQoUd6IAYx0I81oG
         th/5mVMCxb95XLKNeos/LDwlxLtdmaCJBkSCkpnq+pftyOZjhVAvxvEuy6I+Ci82VPtP
         TrL3uo/pwV0cX7nDMaKu5bihh9jg0SxACA0xBrMy33skFEQAawEN4QR0kryp9XKZ9FoX
         HuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791049197; x=1791653997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFnqgsSeoGHR1ZREgHRbdn6RIhZcMzx0GUNeyE+fwl4=;
        b=Bq9vc14BMND5ODv4pCs/YMmlL6pUAp5qJ7HtUHvTJGEdmBkLNIDLl0OIq+5CV8KPpt
         G5aIzBubjvN3bc9iwAZZqgcmbjvftGgRSJLCeZxmV0pdQDmSXl1DdvaMqhWp7AwJ4ceu
         rCKwvyInGYm/jfreqgAX2wHE2sDeH1wHH7mMI+FqssEapSB/pUvxFkvEwm2xA7a+rtSs
         360D0sgcXS0/+IPOmRYANhSjtyPwHPXGI65X4mDdCi2VG8eHdN7k0aJAcge0l3m8UvDB
         Mdg0/4vfjsbAxxNZkHMjjH6OVaUZhaFmZAZjL6UjRyRsbSGSK8rr8bzxQEWjudF4m+1U
         SyVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRkH1tf448p9+qe+39EJAFaIjqcGsVByCB35jrqqZ07kj1h8vXW+cG7qjyMRMN0ALFqs07zAg=@vger.kernel.org
X-Gm-Message-State: AFuF++mvUEtbmAyDJnjIGL0daafKqZJp5B/FdgpGhAvBiqR84AVTSTXB
	1yrAG/gDZc2XvN2s+7uOCDUkob/yL8d7vwKGss4cj2EuM+vVT4K+LllGwXg4C47LC8u8Z2rMX61
	glc9Ye6tQ/I0XGqX3d8UtcvgkTMLGKv8G0jkrpm5A
X-Gm-Gg: AYBFou2I/BlbuHG46uSYqeJCOxTQ7O5Q0Fl7JkNesolrdVl9288oRy2vfeKOjxlM/U9
	iGrWFPZcphCUYa057u19TZMQFXGIkeseqJde3C4+WDG5semPA3uZlA/ICsxcMyZVvBt7BVIXJ/Q
	pVEnwHH5/C7IATHPs+cU8iY/Q75JaNCLeIkePMOf+Lzqn75foxqLluJ4PU2kzh2zhKxLQPEdI5g
	vo2wKLoBFZVk0IaRI/BGLQgwLL4JqaLV0iAaT/WPjH1IJZ1nA1DOm47DhmMS1KxYzeYhGu9sFKE
	C8VCL5rP5Bl0aOIXuJ9jzEFQZSZuhVOb2pzMVqGgtqsmQvbIxtF/E/QNwcB2mRcKGmxQ+OMozNh
	udg3uYYgBOIey5JOtYaVYXxxwZPNz9cePn3V20P+d+XDwkAPIaAlWOuJiElser3cxA78jFfrp0Y
	WDKsu0H9iUAo6GuBNQw6NqqA3s
X-Received: by 2002:a05:7022:1509:b0:143:3c9f:109e with SMTP id
 a92af1059eb24-151c425fe14mr4276645c88.41.1791049196034; Sat, 03 Oct 2026
 10:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930162457.4ajVJ-Qa@linutronix.de> <20261002125357.200a5aeb@kernel.org>
 <20261002215412.lUoSB2XU@linutronix.de>
In-Reply-To: <20261002215412.lUoSB2XU@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 3 Oct 2026 10:39:44 -0700
X-Gm-Features: AclHuK97qkSua9kDfu1Qq2nIBDYZXmqwXzgzFlTaBvNFH-pAmZ2WGZ7J_B8ry-c
Message-ID: <CAAVpQUCuV_MNMzWCUBOEGN3Tsvykxq8Ba5cukzR9GoOQjh5asA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] af_unix: Do not wait for garbage collector in sendmsg()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nam Cao <namcao@linutronix.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 2:54=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-10-02 12:53:57 [-0700], Jakub Kicinski wrote:
> > On Wed, 30 Sep 2026 18:24:57 +0200 Sebastian Andrzej Siewior wrote:
> > > From: Nam Cao <namcao@linutronix.de>
> >
> > This looks effectively identical to v4. I'll put it into 'Needs ACK'.
> > If Kuniyuki is unconvinced please do not repost this again.
>
> basically the same, yes. I did try to explain why that flush does not
> improve things. Also I added my notes (as a reply to the patch) where
> the bad boy consumes a lot of memory and the GC+flush do not help. This
> looks like current limits are too high. I am also not sure if the memory
> account for sockets in this case works as expected.

It works, but only with memcg; AF_UNIX sets sk_allocation to
GFP_KERNEL_ACCOUNT and other objects are also allocated
with it (or SLAB_ACCOUNT).

The default RLIMIT_NOFILE hard limit is 4096 and fs.file-max is
scaled to only 10% of RAM, but systemd decided to blindly bump
RLIMIT_NOFILE to 512K regardless of host memory size and disable
fs.file-max (see systemd's 52d620757817, a8b627aaed40, and
09dad04c49ca), relying on memcg.

Also, I'm still not convinced.  As mentioned before, flush_work() is
neither for OOM nor for the case without dead cycles (any process can
keep RLIMIT_NOFILE FDs inflight without cyclic references anyway).

---
pw-bot: rejected
