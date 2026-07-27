Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF742BC34
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177658; cv=none; b=dHD3S32Pq8Tc+WCHlBuYON+UlpG7wHxdJ/4HlprvNL1vaTzcUbgd3lKpLqzsbMM6gIK1uLxO0jGqDMWfulwHbwdomn8MSlhXYZALychDk3nItmVnkRie1gESe7iJY5FBu58b6K4GsfG2RJA/XAnGYwZNPItJLRyKorYVijLMxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177658; c=relaxed/simple;
	bh=gN2n6HVonTVVY5RUxGyroVEfngLQON4eG6AmGqWU64k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4gYMHW+pFnfHdpKmnsQiIGMRQu4NerDbYDSdXwh+7rvVI4QTLTI3E8diufQTissj0obXgrl/SiVlK7DqtTkG3O8MtvWldjMRLsu6yAZcHLahXvAkyEzVXaJmKEZhJSsiL/Y44Gjec8UC2VrqyaZRBeX8qwzLYtMLvmcY4+wRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fALKN43V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShtInepE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fALKN43V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShtInepE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785177656;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5htpfKAJ0tiaPHVobFw+9Qbwgd0UVHrLBU/rphDqng0=;
	b=fALKN43VoeXUZx8xi5RkONBEzHX2sQTwFey/Pr200iq7fhN77hUdYabBzJjhFUTz5EBpu6
	NejpAscCklf1jxBWH/WQ4TJ/o7FVZegIqRB55vNlLNCzY16dTK4p7kn8NFxm8wm7GUnDyE
	IRwbp82qnWSFmSSgHb/02VSXfleJuS0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-nTtkzJKtODGri97bQQ3s3g-1; Mon, 27 Jul 2026 14:40:51 -0400
X-MC-Unique: nTtkzJKtODGri97bQQ3s3g-1
X-Mimecast-MFC-AGG-ID: nTtkzJKtODGri97bQQ3s3g_1785177651
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6a13b72112dso2998750eaf.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785177651; x=1785782451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5htpfKAJ0tiaPHVobFw+9Qbwgd0UVHrLBU/rphDqng0=;
        b=ShtInepEH+7SrGNErP0l+JX/hzjP3n5RFKyvTC9eucaf5Q4/HW85HyVYP4IIfk5BTy
         sK2hA1+bHmNJ+utsl2NHZa372QKnMwUt+yU4USlCE5oa5XCnyC1IWp+IPWSPi6JhO9n4
         fjN64/YJnkt3TtAKcgxdVFku/gIvjju/eJes6Dp8r8IsY0GgCm1jIDO2LzInfm5Y7eiE
         wqDN1MuZbB/oc5L2ekAkopA5bpYKsxZdG/8j/s+2sc7n3zmglt1bxcEXUp0xtasVBaRd
         5QpCa9dZE/ox4WM5r4rRGb6cFbmfS3ZOrrKLEfTgX/RBzx2nGAFPvO8Hty8XgpLbNBCz
         OAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785177651; x=1785782451;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5htpfKAJ0tiaPHVobFw+9Qbwgd0UVHrLBU/rphDqng0=;
        b=HUHtu2okuI03F5doo4ERQcnCkxTGc5oOuIjYptS6GMGcgIgOqkNcCp7JKauAX+ZPuu
         +XhGIGu2ESsP09ipvw8glwB5eoGiXdrl9O0rci3xx5SJ7pdHrj7NjfIIAhqQoFUGoJLV
         z0BxxWro8vhDropz1tQdVSeBlwwpNrwrOUKQ9T2tbnS95fJ4id1yYY62cHElwxAZPAzt
         p2c45+yF5YuOnn/1LTm3FNEDUi5dgXi/s4ufWhuCk9u3WZt2L1hEP4PMaec3FS/aaDsH
         CxkdwRLEvqZSpNHSjdaIPr6GZfgLoy2v1D84o0eHLlgZLjYrMNyCw1qowb03N3w/3Sd9
         CfMA==
X-Forwarded-Encrypted: i=1; AHgh+Rovsg0vlHx6xv2e11OPmgUDrRnwRvyushWGWtOv9bZQR3u+oQh8HkqzqwS3n1O6fsEZXQloROE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhAW9a1QkScdngWEt+pskR+IWdKWZ1mSfD/L6c3VBRg9aXN4N5
	YwjweQoG8aQdKiryHKwud36qeJGimyTHtO20UtIG52JWMmK9WasX4JbNCoibcNIv9Q4n6e2TSB8
	dR/uohjZ9baIOJJYwsygnM8TtKIgkmvoL8j0GjamoRj2FXwD/HsYgfIHnRg==
X-Gm-Gg: AR+sD12a8ZKM0Nm0trTzbROBQYVf1fod7Yz+kv4SNhDFTlm+RIWJyXksoj4h5LHddfS
	+Oz3+sxqL9lUdf+tc8M6ZxTSI9Cm6tOHWFDQfr23Jhi3cnDpvi7nkBfNQ4WuJn6+8GrD8MA+QuI
	e8h4Zq9XmHc6Ei5AlVMTANpK01HMcUsX9CNmBCXx9oaq5g2m6VPhXSezdIsdHSnLgyTd4+DqRnP
	H3bRXVMYxZ/a1cjytQB3NNgOF2i/0sqGcPeWI1t/gGs6o3KmNI/OiIAyJYjVYfJCQJyu/4/3d4e
	vH3g+lJ/73WXfjiijztG10R/LhjRWpcBdLs0LHmTHQsuOr6abHwLlsFo/9VlgLy1iEYrMlHu3YF
	29KoRsalfCjUS0zoKfP1dTlcrARRLKxl24dX8XeWH
X-Received: by 2002:a05:6820:5050:b0:6a3:7822:9396 with SMTP id 006d021491bc7-6ac90e92b9bmr436387eaf.58.1785177650950;
        Mon, 27 Jul 2026 11:40:50 -0700 (PDT)
X-Received: by 2002:a05:6820:5050:b0:6a3:7822:9396 with SMTP id 006d021491bc7-6ac90e92b9bmr436374eaf.58.1785177650578;
        Mon, 27 Jul 2026 11:40:50 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457674879f7sm16838311fac.13.2026.07.27.11.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 11:40:50 -0700 (PDT)
Message-ID: <0cf6583f-7115-4771-9b18-62f842f53f50@redhat.com>
Date: Mon, 27 Jul 2026 13:40:48 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH net-next] net: dns_resolver: allow shorter names in
 dns_query()
To: Paulo Alcantara <pc@manguebit.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org, Pierguido Lambri <plambri@redhat.com>
References: <20260722-net-dns_resolver-v1-1-c3385898ccf9@manguebit.org>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <20260722-net-dns_resolver-v1-1-c3385898ccf9@manguebit.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/22/26 4:28 PM, Paulo Alcantara wrote:
> Customer reported a problem with mounting CIFS shares where the server
> hostname was 2 chars long.  Turned out that the CIFS client wasn't
> able to resolve NetBIOS names shorter than 3 chars.
>
> Fix this by allowing a minimum of one character per hostname in
> dns_query().
>
> Reproducer with samba server:
>
>    # 'ab' and 'srv' hotnames resolve to same ip address
>    $ ssh srv ln -s 'msdfs:\\ab\\share' /home/shares/dfs/link1
>    $ mount.cifs //srv/dfs/link1 /mnt -o ... [EINVAL]
>
> Reported-by: Pierguido Lambri <plambri@redhat.com>
> Signed-off-by: Paulo Alcantara <pc@manguebit.org>
>   		return -EINVAL;

Acked-by: Frank Sorenson <sorenson@redhat.com>


