Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587973;
	b=XHQoixl5gRdJroXjysA740unqm3duwCfZHXpT6bYKs9Bjtkzv3XsnYw94oT8oZctNkwO
	 7r2wjdfIaQn3+kul83KJQbHWHnIXgN+GcA3Io/ZQbzVGB/PYi4lm1xzkPxBexvaWy0wPE
	 3GVYK9wH8Jeb0QNPk/oIcWMXXE7Wt8Ij5SLITRJ+8sU3xsf9KdQ4I6nvmM6Ofs346FVS/
	 +5z1nVMEOMLZ7SjliS9euKlZvQltmhB7T36FB0cuw51dfclZdqrIoeT4kxfSoiyg+m4wL
	 RIHwi4IAWpigJkDWXm8MP06Rr8gOAScgJch7B08JYNLsvA40CXVc2EOMiz98nlCzyJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rw2+Wu07AzcSg0TC6g7lPJt693i+bJC0ptoRBW6zeXA=;
	b=Y/ZayP2sbJbnRRQLYbvsEMdr3tsHcIP9+dhfycAqHwtK2NMD7AaiCEb8hJXjdKz+cmlJ
	 wyReBDdabtt4bV0RXCsv8QpJqnMxaFOKkSSH3lpzUSFa+Xhqd2Lf/qDvp/ffu7J2ylXED
	 /QryImVvJ5YqKWH/3F39jKTQy8hWucmBQ3aNDOSDBUSz6ncEjMjIaOkbxDCCIuvkmT4Ny
	 +yxb3WoV67ZHCIidYdnY0SE6Mx2yKMsRicwA90DMbf0t8+gLP6h3aTz3ZNm21sG5BsLxu
	 GJ/RL8RcI2c/e2FQbVhfEAS2CZy/qcpWJi1GtSNbnbKyer7eBwj3EhHEKfvUQAuDCSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJxwPzei;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A4606A8B5
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 16:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687A4606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJxwPzei
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b757029223so1792384a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:39:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587972; cv=none;
        d=google.com; s=arc-20260327;
        b=m4Ucj78cJK1nW1TVyumG2oqhosE9LWrR47mDCOYgh/zjxx4H9Y4J3BqoFU0kl92bJ2
         gCSuP5VoJE741rUSM/pKZLs8DZEZDFx/cx2OA901m9sh+IH/JnTwk0jEs5kedxQyxIvg
         5raVomQyR815iO/mm2X8ImaObjdj59RXdRaoGCGe8eKl+Bo0yGyqiHRutDyPfzAfqW41
         M6dhsBrzaT+guuIN/sQXVd7yN9xIicHtApL09bvYEZ30kBewwWlUWryMebt09JAwhcDm
         5pQ5UWty3vGNymAt9Lss/eOAVu/3REelEWhRBScwozAVWlLkB/mPaAvDO2gXW0xN6fHF
         LXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rw2+Wu07AzcSg0TC6g7lPJt693i+bJC0ptoRBW6zeXA=;
        fh=G8zx+hNr6rp3yhIroxRoucrIE0t2Rh/BzmaRK/LNP2s=;
        b=cglrxrQsPA+XjQiQ3H+b3LFD8iNLvpj7Afp8yS6nVpbP2aRyIQAd+a6A7U1sn/m2Gy
         BrabuRuuiGP2+BHDcDrAhp6Wop8nnhHgokxcwnRtcUx9uhOWBvn5yUiA51xmmvrtrcRh
         o1qGvjcRkplLar08GLQgg6w+lh3XCu7zoXNHe25545ufg3CoY53MaYNoUcn8v+XdGpCR
         y7iroWsPAMTNpYkVWg7ZjMADaPVHd7CPOtvSnJLvkbJgJXrb4CqvTibSYtCL7aHs/Y17
         K1owGIdlq2NISLp37QvetS3U+VNgfZ83CAJRYgf4JMrS6MMrn3K1bO+ZSTncRtSblElc
         Xgzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587972; x=1795192772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rw2+Wu07AzcSg0TC6g7lPJt693i+bJC0ptoRBW6zeXA=;
        b=PJxwPzeiqzZUHmNi4ZpZ3CE/irx8leO5P+PLZjT9cYIqt1Ihc6LYUfmTeLM9OHRujM
         kiWqrg2HHxQbBnNW/0ZYloJ6IDoXIZ5b9R5QGqxqnzf2e3q8PoqIRymnhNLOpJphwcPY
         ZYLi1TAawjgIbAZUINRghR/Z80Q7GkS4PrlIQOGUjx1UaZMFDVmzhTOpvEisrBM7yNt6
         l4BqKOWLY7FoDYpD+O0m3K1cMG6r27O3NEhNdrPS6gBIYjxao0+YHpCbRdIDxxyllrgY
         AazhY6bBo6qoiveyrTxbK1OnA/duerPVRxa5O83ugyxoBT1IhEUpiHRvebJRe+uTUqPZ
         hXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587972; x=1795192772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rw2+Wu07AzcSg0TC6g7lPJt693i+bJC0ptoRBW6zeXA=;
        b=2v3noJSnjEdpCjq+5CaTdy62un/2HxkZsqSldAGgNhBirczemitnby7+xwT+6iM3xv
         c9tcfGly9RQz6NSAiC/sMwlhdS4EAg1MPkQf6yKVA+qxZ/IRNxVyydOBZnKFOqTVd/wb
         ixIonhXyPDgIOLT0VeBsmWAmjYIRlokc9Hqf/XhpfxDL5tiwj+7TvfyD16Vrv5wh59zr
         CbKTlpsYulRkaZ9kpUaM0V4K7iqa7bYt9XZGUXTXRMlo1BvGt8DZoaQlPQ1H6DOYhKZD
         8xYPRyrB7QaFbpylp6vS5X0Ll1KkNuVKAMd2f5Isu/oE81tLBc8rPbVWfy2R35yX+KUy
         GA7Q==
X-Forwarded-Encrypted: i=1; AL+hErFHjBRCV/z4Ebz3EWRdMl2xEyPIXVQ+4+7KRYly9UYKuGYdeneiImUFgV+eAci3tTpS/8bxo6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tepcqXb/V2EydWA7xcRfKvVTieCYZnsVUmqelIQvQcr7BmU/c
	IUTIzMy9o0DSvWGmHkSKdIONo4msoxPpsnpBJhE2eS0HCxMZOIusF32SZi5NfkUfKXMTiXuLzAP
	rVAn9yffcSIC94CUaU6jh575d4ZQsi/k=
X-Gm-Gg: AYBFou2+p5hwqoeWY9IB0MUdSsqrtoUaMFUocLcis2GsRxqwPkPbGrWzUebZyrOPQDV
	fCFN6by8ToubiWg5aanBzf759jKUkWeiAc8Qb22WKmNibLGLLCNxjxq+PLujmHZaIYyrLi1VxzD
	RdpHg1jdIfqG/7QU4LF2nlrKHYh7Q6hw2xxF9YgbnRjSmjgQqmAytzzpOcEsCFVz0kGyYxwaV57
	PwtyAP2ERoLJx8Sn7hJYAbwA36er0iq8uX9AAYC2uatzLruTZAEYGE2gasC/u9cJym5rr0jJJC+
	MWAwjg/VM3YWTMT4XrYOWTRq/F4aOhlB12j64A0qcHSm7VF6kay1Rm9RuM/N4LqawB09soMMDH3
	KywwakDNah0mqgNPgJ2MiZAFKwHr3KiK4rjsT2MOMAF5rPUORdXl3vDMLeyGi7wF12FztTg85l2
	B0QAY9rhgDirRgcelFB9HVxxFpcGUk7zqKt/vMj2gnDajVVKecGbWzj50o0PTsCpsUdMqm/7/7C
	dtI8P6MMnf6BonHmltNbyBVwdSWIgY=
X-Received: by 2002:a05:6402:90a:b0:6b7:b872:27c0 with SMTP id
 4fb4d7f45d1cf-6b7c0c86ac7mr2641866a12.44.1794587971407; Fri, 13 Nov 2026
 08:39:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com> <11acd5b1-3099-4e3f-9fdf-a3c5c6f098c4@lunn.ch>
In-Reply-To: <11acd5b1-3099-4e3f-9fdf-a3c5c6f098c4@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 09:39:17 -0700
X-Gm-Features: AclHuK-0ytg4Lbmg2sk7INYSUK5YlLS26Oz4Ge_M8WOZ7bj0w_qDEbjGo4B5KuQ
Message-ID: <CADvTj4oPugtaeAXPvjJ10nhfKGDWTKbtALfuyF1+wUsHu2e90A@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net: phy: restore driver state after userspace
 MII resets
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Chan <michael.chan@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 6:33=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Nov 13, 2026 at 01:48:39AM -0700, James Hilliard wrote:
> > An MII ioctl reset needs to restore the PHY driver's configuration and
> > software state before the PHY worker can access the device again.
>
> The MII ioctl is a footgun. If you use it for writing registers, don't
> be surprised if bad things happen. Even reading registers can cause
> bad side effects, like missed interrupts.
>
> The whole design is broken, there is no fixing it, so we don't try to
> fix it.

Would it make sense to submit patches 1 and 2 as standalone fixes,
separate from the reset recovery changes?

The b44 patch removes a spinlock held across sleeping phylib/MDIO
operations, including ordinary register reads. The write-error patch
propagates MDIO failures and avoids updating cached settings or running
follow-up operations after a failed write.

These fixes are independent of each other and neither adds reset
recovery or attempts to make arbitrary register access safe.

>
> Sorry, but NACK.
>
>        Andrew
