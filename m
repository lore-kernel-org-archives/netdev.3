Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794624487;
	b=vRhTHfwVdjS0Rd7XyruZOlkoV+dGBWKLAX0ZJxWedyn5IvTW5CWSKWFNHDdCfzj9lQeg
	 6abqsa++nmDdwRlth4wXDSAuSCZTCOGFRxxB5aaxCvtwB5zu6vQ1edAibq62Zvoq8fIak
	 YpMWcLH235OEDAliSkOG88tqZnIP2W1UEFobXK2pnOA9bfdmQuhiA98iM+sSNssUDwMVX
	 Y8a3mRVa6OqX5t+brq/NcYKIYv9cVJXqCNOnR2m6FeKNMANrQ7wPLg3t7H7R+C9B6X639
	 jJ5hzYsY/lzaN5EUivkcmskcLnoJeLA/G7f7rBP+H27i85fQYzrOpQrtRmqwZ8N5GgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
	b=iWtIxj7Zv9T5x9dtU6cTyp8oi5uU1gKuHAqKo6ZAwCIGvkGtBSRXW2mSXdAjsZjdcohf
	 g4mvrM5YTqzHnTb1XOoUBXXjlv8Iucg7mUVemQGp+BBkPN4duI2wNmREvyJ7K1AgO/RMk
	 xmvcwqBKav2QTxUS9xTu4+2wh6uJxa+2oYfMI0CS2BldeJwJLy8Hnt+8C/89pAFVRUHO7
	 oEaQopkvRbhEfjwWc5fPY4v3HR8FumEXtOzPb93jVnPtLmP4PJ7+5N9ENp26ulvuuLNIu
	 I9o/SC14y6cwr5q+mJeLPFsxf5g9jYISN6F9as5CfsTlAF2YHAZTy6CXVuVonJ12yNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4FyeRk1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DFF606A330
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 02:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51DFF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4FyeRk1
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a058315c79so1189194b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794624487; cv=none;
        d=google.com; s=arc-20260327;
        b=WrQxyuJuA+rTnx3OYzherPgnq8BZwqO3ejlYsHBnaNV8Qk7XZmn4LxzoVsv3+pdHus
         9jWmli6XURKp6jq51sX5n4+RyeBLGZoh3M/OblTDq5QKl36rCAjzZ02I2W8P8LErG4B+
         GiVbrNX9tt5xNzkRedu8TjBdJuOYA6gqZvBBz8tG8NqYy4Tj54sE9ADy1GemW/dF36bV
         FZVyo8pB6lBC7047GZYWFDSK9vzoS1/5QJ2Kqu1OOHv1h+LkFV63bWqIaWIZfN8bTodV
         iucZTmV0h480kkYhk1/sbBejYHJMqIzq89joBRy5rD2gJ5dfYoEGQezV+kQ7XdqlBvM8
         ZGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
        fh=W9tEeCzAnfmthGc5YEQTPOq2pz9k5BTpzjN5eVm6Yhw=;
        b=gUt4+cD+2YZ5S+8RUZS5RtkhZcOZ52PcmriaA+YCRssDiW6G9Hb/zHVlh2/hpZYAxe
         jNtkFBejBTwtMJ8RVvGxAxpbsIoeCJK0N7jESZxgpiGbSYO9e4Agm1XiusXiIjTQ8rjr
         3QFGHAwHUoHJHcWPcIxRkyf0moeMIhq4KAx3jRmDtgMgRWryrzayJBXQsnMRdoNQsgIK
         nomKh37zlpmUHS8hHDiLoQFKs47I4IcDVmM7xw09hDAuvSyho7EpqPdc11+XiknFNyJf
         MJW7HSHpun3YimdZ366aZTQBGKiZJbOt7jQRPNDsoNfDZGMDY454u//N5sI0SbbLF5Xx
         6m/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624487; x=1795229287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
        b=A4FyeRk1XJ5lhp5+6l9ZBKBqUwvWOsBjbrCJLUbQu3jAbgp3KA8uyNP9pHrdpAYGiL
         ClQpGQdJJv0C5mBcC7vU1bNi6pGxXQyhQxdbqaz6tpfYab7WuvqXLp7x+AYglubSPGnO
         9Ph7vDuPVlRTSU3GlIAltSQRxMWr7X1I3sWjOwdugucoFiaDEQvM2ZfJklAR3h2u5Lh3
         p0Y/PCrCqrJDHLchOYoGd+PC4TMiLrIIM9Up2g3BEljJMM/FJa4tH948Rt0wkUzEpnca
         ntTkmQD7qIGBr8BsiqeT2jS2tRf7XH8DIEAvHD/dIjOMRQb2fLcDh+qvrIOCiC7k6ct2
         25yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624487; x=1795229287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
        b=tjX+jBH45tdTaervb/R3AUDC3NEIz99ivylyQFJ+JDNXl0LCd5xNs8xeMsUrtre9z8
         84vorqvfT28EbjZS+jXWz9WVKQpJqqfW1Hwp/ixH1m1cjKs8rXNNd2h4/IsorDlR5+W6
         OlekyRaTSOyWDXOOw/uLy8zlxWZAowPN+b2U6pVtmVV8SiiVvHqnUEzkL1tEKuPqaGZV
         U5NO2QngoUgExnX+0NIV6fVsUr6XlZ+HZyfgmtbEosEZ4AnaIiuXGqk+tQSPioJ3FrBq
         sBCfpOQ7ebsyauBLisoSBK9pWjNLhLcP9Jc8MotVyl6NZe3m/s34f5oZvAs8f0UUEBmd
         AFaw==
X-Gm-Message-State: APuU4Z9htth5UAQlsQF2n3v2ebFVGWgvxXZN+/FUV2bcqZo4q6YCmTx3
	ABMlp2+ugL6CnDVMaZHTFthFYR20+9HGH1p1rcK7rVy/BPJOVXu1KPzZ0D3+Bgxo0wHHdOMDREd
	oJr8MLxC5ZYW9uELyjnK8Os2gZDyYJAA=
X-Gm-Gg: AYBFou3FMgpP5w195bchSepvHpLyrJ4YD5pwsO+JEOT1ToxA7WLnTMODofspPCdsiRD
	fsRW4EqWphlRK3/7H6isNX43lHNYMS/LjSJTOKovM5nKyuKkMSxaPTcJcGcwLkB/LXYFQdxl6Jk
	dapX4crjzpDEI9qJOiIlWeSDcRLLNbS9T14F4Vcoj88d+f1sc3aV9R33z+q9svU9T8aZSRVOcYf
	MRhOQazAQs3uuvUPCeUE4KSXsHYVVZo6VNcQlWSz6awJF5F/LHKo1RYAUhF6NbIyaYz/NvzMos0
	VtyZLPbZxbVZlCqRmQTSZubf0MTyz9njOcTG5dAllu38liySBe/qEWCNH1uDjNfs6LbzQVHUTTO
	jAuxtfDQs1d1Qo3yMLeRpAeXgZXRq1mI9hRs+q20d6ebN30dWnMfLoI5pUCh8frQyg6JztRtF7Y
	ryU/d8O/wyPypn2CB9Xk14X+598u+JEgTsYWIid9uoc6FXW0H7/Vs=
X-Received: by 2002:a17:90b:1d03:b0:3ab:c80:9365 with SMTP id
 98e67ed59e1d1-3b1b0b4cdf7mr3736445a91.42.1794624486524; Fri, 13 Nov 2026
 18:48:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
 <20261111155748.11b92b7b@kernel.org> <DMSSYAEKE9XD.Q3C9CEHH7KTL@gmail.com>
In-Reply-To: <DMSSYAEKE9XD.Q3C9CEHH7KTL@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Nov 2026 18:47:55 -0800
X-Gm-Features: AclHuK_GHHLj0tkZe8WQWt60_PoP1RTBPF_tvkYqhr7jC6EW5BMLLyA_qSZQp1M
Message-ID: <CAADnVQJtT=iXRh3OP=-6KdZnZJQQHs1V0KWNtZxYz-KRsMOY_w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from bpf to net
To: Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 4:23=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 11, 2026 at 03:57 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > BPF folks, I made a tag for both of us to merge / pull to avoid
> > Makefile conflicts in selftests, the original series is here:
> > https://lore.kernel.org/all/20261109193048.1006986-1-maciej.fijalkowski=
@intel.com/
> > PR text follows. Please LMK if / how you'd like to proceed.
>
> Take it into net-next.
> We don't need to take them into bpf-nex atm.
> There are no conflicts today and we don't plan to touch those files or ne=
arby.
> If selftests/bpf/Makefile conflicts it should be easy to resolve,
> if not we'll pull later.

"we'll pull later" ... is now.
pulled into bpf-next too.
Just to avoid thinking about possible conflicts.

Thanks!
