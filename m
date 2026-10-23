Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792785681;
	b=lOh+ffstQUj46lI/Hmzrk1Quiz0CU1xbgO3Hn6LmWzeQS+OLhvyxbdsoO+f2gBgGtoEK
	 U1ugUqQcTfV/DZZtzfuWvA/+rmlF8+rrTeHenQEgxzL/UB+f6aSIE9EPNhfZ5s5Cvkpx1
	 BjIFjBSezwTY7xR1Pn3GHoUo8vQN49CmRtz6gAjqrFa3Rp+2SndhSNPqnH+bpXDvW/Pw2
	 mE9Zku/cRqusK3VgLuQEoI/5wcYmbF0g8vOgLqeAe/QgyJrRjpJYpDulpG/6A1swcIryE
	 rH1S5qnH71MfApcgaKHy+POqEOvx+Mclfs8BzTJ+9jwdG3BeQqPcWvlLLiPay3rCRjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
	b=PssYulOl0hxPX7hTIPZbKkZ0WKw6BVDWZRJaEejASBeiobPUX6Ox7pGVXvsAQqDkjNSh
	 GsE/KOjv1p4KPxdcue7UKemOA3EgLil845QbxJkRpgDFl1WYnjoqveyzoz6+jnGYNfa5E
	 VnPRKteWK0594NSQBVbrrPcTLegfMREj/LA4ammYJrNkj33IOfLVcaDUaecVCjVNYBTM2
	 plN2/5jUC6BUaOIykUbgRg2HfxSOVG6gQb5xGeDzx3m3a1I0aBtrSosigx5SLsRTSB9d2
	 bXpwUrB0Whx426G9B3jcaAOW0XDpAruuwcLLLqyRTQWlMvf5S3cmQAGEtW/ez8GH97Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NhRUecM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3960A2636
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA3960A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NhRUecM0
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-194d0c31715so2280c88.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792785680; cv=none;
        d=google.com; s=arc-20260327;
        b=qwnbe33GXeoN3BlHlMvE8nhzMW1iX/XPJ97OOMxKXh0+iq/KMBzAebCco2sd4q/Et/
         GVcJmXPpDB4Nl0FvAkYwsikYZYVApikseHygNA06IWo+RMxSIxQWPVEtW7TnEBLyAXAm
         Fn/qu7MHAWWF5ZHQNcR0yaPyYiiwhJOHS2CVaBKjp1837yYsSOfktCAJvRxy+u1VjWmy
         /YvAJiRMki1IZnIhiARkCbcgQbdw/w9rOCVrmvTHTTwCJXX9+vXZYzzNvLGdT0hkPpJ3
         dDH7kVv9ns9lxmF4BrKdb45o15B0MEwR3UPlyYztkXZlPdrXDvXsKr+sXjbFAN8m/3/S
         HlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
        fh=GgwMYdgDnbSdsvtR1E9FzKVsaiaU4FmsCxHvnR+ptYU=;
        b=SVf/4VqWh5mxCmvIzSkKq/3XGgVnjg7y6fqsDUAWy90nwEHQ+Z3sNoOsOskpnpNK6V
         2Vkr32QoeCmqabv+ppZCKhsNvyDui1prILwt667sli7nies0UdyTSI1RdFj7ztqqzIGO
         gNcMUDXWVheq6ynlRgEmOGS6fr2kWn8+uy9CytytH1awwDaCOshIR+ptpUvpMjFA0/RS
         vC+ZbJ/yMHZA9oxT9bsTtVtbdkbYcqkz8ynyas6ntsIJZ9z89LJbdcaJlIFeV5q6n37C
         ZkRGM+uf/pRi65GQReJnV7Gcb+N756MaUaYo1Dlmn6kNUTrb7ZYxBXHF+LFrVwNkHo9+
         A5cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792785680; x=1793390480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
        b=NhRUecM0MaSyL188/UhVkiKrlBbJzWi/BNVMU7d5YPBuZ4iNj3orcUODsTyxrukgQ0
         sshE9V3b3hpWy4yz5rTLrpU/3T/i7yiZemoOjtjAulVcVzmeu/+uUKXmFKRrbGV8DWhI
         ikhmpS8Z9Mn7sdgQlSNsC0RxuXXxhwIwObzqNeKh07tyr+63U8OQgBmFE4mockOozkgA
         PAdYIBVKieKprNJuM1Pvbqcymrtd+kJp6cXgA8iSY9nDhe9RlfG2ie2TZtH0ORW8F6sT
         xplVtIhXO2sZNExMdYq02R2Ax6WZmI4WYtHnZTJHSjY1I86x9aF4mAg70ShzvwGFSOk3
         yU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785680; x=1793390480;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6P232PvLRYTH0fZdfO+3AJcU5WVHpT1tzKpJhoLyzQ=;
        b=SbIn2ttxX5/M/O4IF0HbIulS/Zbds5Inu++2dhWPAiitxclBwIfx9SDLNKPw8+bFF7
         GBj/02J2MqUILtt2zLZGMvBTutuFO0xULiaS8XmjvOqa1mpwhXeFhq9NBsVLTjUxFghe
         GAAl4jb4Ik+f3uXAJgm/2iPWJcnEmak9wKNPIIerzE7ksZfaIhMU0zhcbsbsy4VmVOXN
         8vHxX0r0MRWmu5b6gWgg55VZVMJwPHuDAyW1ZuU2Efk/Zk0oTZzaU6HkHFK2sQl+IiYj
         /JEvLRixVGB/2AtBOApKdKShC+Fdr6G9rdojfS2GCNB9Rg+o3czvEhc5vzRl5jnRqbQu
         JiSA==
X-Forwarded-Encrypted: i=1; AKwUvBzuugNjnbioUxo1VAWqadNNZNnnpndI657vS6UX5PaknIoN1xXDnrCIRqWxZKlaRdh8NahYt6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPKDX1EcVEbHHwaQx/qGbA1r5eqGQYVoUhlgSoYIHjtv8FHFfy
	tnZ/I6PnK8Ax4sNKMeoHAXwy67nqzr1D4Rof71JFd7fDCZXYyvhIjHx4PM2NhTxhfT5m+zQWy2A
	j6vGOxZTzXxSEtMJMZDeIAFn40OJfxuF9U4xKhB3x
X-Gm-Gg: AYBFou2Liwo5Z8e1ei0tWq7F1vvYBkhuWn0btYimDAQZXe552/0vjOMOkqyVf7LPKn+
	CBqiAdwNLzMm0YNIeiW7Aidm5gAz8Hzqzl3SfTNQvLfT0igeCpubpWVjQ+zKL/TkYu9i9DTeKn5
	jmMBZda42KCUdZ407u2pfKf+dmbpIwM7AOxVgF4kPZCufp+Xl0ncTQOMoJ2zgBUPg8FtKFWNJvs
	uH2h4/iqYOsyWHRfDm8fPIe2QwKCZqhLeDlFMvvt2wQqNA39h2DS5BHkUBKY8hc8nDh3OkX9SYb
	0yTYspbv5F7Zb4iyfmeflOyiuEI7n9ZmFqYU0dw30a4VZiiiqUjbjqkxu4skhdUhxRJzHUHCnxL
	nRdlQlVX+DgMvnf0jMLCl+aqHUrjIlqHCBwjr
X-Received: by 2002:a05:7022:4587:b0:184:6afb:b26c with SMTP id
 a92af1059eb24-1993fe82542mr15165c88.18.1792785679160; Fri, 23 Oct 2026
 13:01:19 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com> <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org> <CAHS8izN_N25mm9vALax+P+W45gyxVoMbZoTXW3r6nPC2Z0A7JQ@mail.gmail.com>
 <20261022181911.5d19ff13@kernel.org>
In-Reply-To: <20261022181911.5d19ff13@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 Oct 2026 13:01:04 -0700
X-Gm-Features: AclHuK-uP7Gir6yY-QN4sOQ103425f3gALMoJmdo_Tw66r7N7gb2W22rdmAKl0w
Message-ID: <CAHS8izOTLYU=5sfJvpwB57Bp3tJ=xt7Gwws5xCVqABFw4T3WUA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Oct 2026 08:41:43 -0700 Mina Almasry wrote:
> > On Wed, Oct 21, 2026 at 1:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Tue, 20 Oct 2026 23:17:34 -0700 Mina Almasry wrote:
> > > > But on the other hand the test coverage is nice, and maybe one day =
if
> > > > we add enough devmem support in netdevsim we'll be able to fuzz the
> > > > data path or something. Is there a way to get the best of both worl=
ds?
> > > > Like put a comment on top of netdevsim that this is test simulator
> > > > device and any missing functionality and/or bugs in it should be
> > > > medium criticality max or something? Or is it too much trouble and =
I
> > > > should drop the netdevsim support and tests?
> > >
> > > I already strip Fixes tags and apply the patches to net-next.
> > > But it's still a burden. If you're signing up to fix the issues /
> > > review the slop we can try.
> >
> > I'm more than happy to help but I'm not sure what you have
> > specifically in mind. What I was going to do is put a comment/readme
> > in drivers/net/netdevsim with a note to sashiko and LLMs, "this is a
> > netdev simulator, used for testing; do not call out missing or
> > incomplete functionality as bugs." And then hope that the LLMs and
> > sashiko pick the directive. If not, I can tell patch submitters to
> > ignore sashiko code review bug findings in netdevsim. Is that
> > sufficient, or do you need something else from me?
>
> No, the fact that it's a test harness only impacts whether fixes
> got to net & stable, not whether bugs need to be fixed.

Ack, I meant like if the bots start to consider missing/incomplete
functionality as 'bugs' when it's actually missing from netdevsim on
purpose because we don't need it for testing.

> I was expecting you to keep an eye on the list and review any fixes
> that come, basically.
>

OK, I'll add netdevsim to my email filters for patches to review and
see how it goes.

--=20
Thanks,
Mina
