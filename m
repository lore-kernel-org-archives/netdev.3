Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513A4E020F
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548964; cv=none; b=Bwk4lJNo7y16jmpa7ayPhqUJJPsH85XK1x97vNs4g9apHoaa72QnFKZmbtEU2omeS97WU6vcf656TzkZzDxfbxPy8fATmk7CQiycmhUse1p3cirQYjnTqWkRc0xD7TlsK63gzrL7CgTYMf/67QUvzppCo7N/qunze8lAGUFSFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548964; c=relaxed/simple;
	bh=ddagq09YQl/TKZgF3VMoaZENHGAYSCeBLPQzpdMd1cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzXUg/AMdREY1F1rj09oS/VnAuwAs/5Yb8MzNiuU2iBo/RHpnrvQP8jwqwO15VclK4NgGgg/IUIu1AXjKMHXbWbRa0mvWb8nar6zGBaY1M/1pHkhcL+wae0g7OlWvpVlaJvUL/U2zrpk5UeBRzUOy3Kgv1ngBu3efzeOfP2U7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OVwOuw12; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OVwOuw12"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b042c0759so3282135f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791548957; x=1792153757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YNYNcm3g2Dr44VNhjrxLCscrRkBQxS3shsHHjVsm3xc=;
        b=OVwOuw126yNbYcIGmAPRfee+Mm4YZ8ahtqTFdL/vzRiHRWhugWAJ4/jHBApT0mu9CA
         FDJh03jq9/9XKpjBPusLyg/Aep8egfDqOwFTtM1iSXEwMRoMLQ01a2Hc95KhGF7+ktSf
         QSkoYg75QnCGRk3uT4KUZsQ2xKkSolwINNufSyqmDQimkjOumo591eOKgapPioJuQyCA
         epguP8yMNVLiFBvHAgRMURwrw5GaTOWeCtOcIwCq0Ge4IKiKvE7xPLauLgo/70llyY/B
         Qrr1LVhTOrX2AUOi9D5wVXS9Skm8ZQQ0YlHlQghTdXstmzuC/o8k0zTjAl6Ws8SifYiL
         g2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548957; x=1792153757;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YNYNcm3g2Dr44VNhjrxLCscrRkBQxS3shsHHjVsm3xc=;
        b=xLE3ChOY8QtLvKpNhXHhWg5cbHiSK9gdiWJQlSikqD/zsMlvwizESFv+3hx8e60mZF
         1qPEhknKaNL/IgYlfgmIFEu4rwWHZoyYBBGVBvGdlNq6fKbSC0EC8diKeSjr2lmSvR60
         ehI3TXMybZnkSsZtMojRxkGsqPn3WzoRqA1liaUF0Fi5arAbf88sJ7LbAxvypyUmMPPP
         Z3R2GUeE5UvcCD301xfzgCgyXjYBQQbExi6vKSZ2uvKFZMBg126enRKDXB634BO/R7kE
         SG6EMAmqB8rYwptGt8SjxLe9TPENhjpouIV0NX5P9kVrqNYJSf/oKu/eEyqAHXgXmtsY
         Vpxg==
X-Gm-Message-State: AFq9FYIJzikmF9JtpPj2I+CwE/RsrCj/GJQWfkI4pyrG1vGnn0vESib7
	TrlleEns0obeNySU28U9bR5fADl6PLwAKreJvob+flV5k1SiCQSOo87O/LeMspRm2QnQD36D8lc
	xmA4DpTazP3cJOfz3tKbREH43tAUCqc5ytLWxZyKuJOxLuz8SpKw=
X-Gm-Gg: AYBFou3W8+1nixTfVhKJExf/G72i5l0BBAGrMMJyUpraz3Ys8RW/5A63FtFmCqiuawF
	foYcg9aA9YdQj4UiiyVeEFrzECIH+47XDO/Jy5a7VIwOjXpkB5wghtaeLT6FZIwh/NGYHZxc3q7
	qd5vW85fM9UDRMcBHVwJg0PeQu977a4ri23Kz+DTOsuJtVfj5JozXtSSICVU132nnujGqUUWgAl
	kKMyMkE1z0KIdkd/R//0hHrBQwnmKxMkHo46SCR9leRCoZ1zPTqEEaTJEczdFh7JF3ym8JLmU1R
	s4ONKl0bE7zHDfDNd6AbxVpXjpw2OsBeLXwP/9W1aDvewBf2AEqXByNaP7ZmuEwkxljMRBEYPOu
	WFfNbc0ZdI2IP6y00lDQNk3DQoJrSzWfnAQ88iX5aHtKA8kw7suAKyISuvI0DMLE+5ip+A49sri
	4+uDSXknVzxufYGbkg74DwPexQb/kEZUSLGQw1YYXHrvvIgNz2vpNW1LWek2xjt/HS82XfeRRJB
	X3fRA==
X-Received: by 2002:a05:6000:22c2:b0:48b:1a0:5630 with SMTP id ffacd0b85a97d-48dbacf3275mr2790286f8f.41.1791548956576;
        Fri, 09 Oct 2026 05:29:16 -0700 (PDT)
Received: from [192.168.182.19] ([185.242.181.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abd574sm3857191f8f.34.2026.10.09.05.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 05:29:15 -0700 (PDT)
Message-ID: <fd4fc9f9-3b8d-4a5b-b308-96969c8c9de8@openvpn.net>
Date: Fri, 9 Oct 2026 14:29:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/7] selftests: ovpn: enable TCP_NODELAY on TCP
 sockets
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, Marco Baffo <marco@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20261007133018.1451958-1-antonio@openvpn.net>
 <20261007133018.1451958-5-antonio@openvpn.net>
 <CADVnQymvjmpFE95MFDLwHJJpusZ+FfnHyLs4+bo80GjtrLhafQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <CADVnQymvjmpFE95MFDLwHJJpusZ+FfnHyLs4+bo80GjtrLhafQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 08/10/2026 15:59, Neal Cardwell wrote:
> On Wed, Oct 7, 2026 at 9:38 AM Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> From: Marco Baffo <marco@mandelbit.com>
>>
>> Userspace now enables TCP_NODELAY by default. Enable it for
>> ovpn-cli's TCP sockets too.
> 
> This claim is accurate in context, but terse. I would suggest a more
> precise wording, like: “Since OpenVPN 2.7.6, openvpn unconditionally
> sets TCP_NODELAY on its TCP sockets. Do the same in ovpn-cli so the
> TCP selftests match that configuration.”

ok! I'll make the wording more precise and explicit about the version 
introducing this change in userspace.

> 
> Sashiko’s suggestion to keep an option for running with Nagle on seems
> worthwhile. Peers on 2.7.0–2.7.5, and mixed-version setups, will keep
> producing Nagle-on sockets under ovpn for a while. It might be nice to
> have test coverage to ensure those setups do not get broken by kernel
> changes.
> 

True, extending the tests to cover both case shouldn't be a big deal.

Will respin with both points addressed.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

