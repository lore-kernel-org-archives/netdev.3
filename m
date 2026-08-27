Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121CB3CB548
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819046; cv=none; b=MEyjCM+Ao/vuLpktiUodPn7CDj8Cf1cXxUOAqUe5c/XdUCqihamlpxPY1u1HthpI/ZRZ9ox4nAmN2jLJrs3UP+ngdl4P5+T+VnBthQdlQc3rji1rQvsWq0i0I2M8e2+oULgS2UNnzUhXrihVyKsKBz02V1z8tCSv8lnSoQE8/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819046; c=relaxed/simple;
	bh=vSxvbDRs7jpFNifaA9NQBhKbV6mMP0jERupIA3P82EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4smNlLsTdCEZZHEC1Sx+XL8lYhKPW2KfGRJu3aRplAzKhAkuDjNBgF+GH2AwVbjt4zKdbfy/27kNolGc8lWcEoyPT7oW4ydLMqwH7NL9YFx0stKM9YoLewt7PGwAOoHab2PKTOgXrUD9FgHIJ6R3Y4GD5qSsONPRLwRKGJY/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiUpW5Wz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkstzukU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiUpW5Wz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkstzukU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787819044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erCGkMBq6wNZzYxKYvBXkMicQIwmnQyBEnM/IZzuXQI=;
	b=eiUpW5WzzjcYkjmt1/xsLqaRo+MTpOmyEo9BN7JjqZHrUCBjAMXzqcEILTttbJbictRSUr
	T6e+Q7YTb7xOeoZuRT0zVCnVMNYdREplhWCRTqr7dLcct/B9FGHo2bqcyYAWJQYY6Bvb7p
	wG7sdG8ged/+/knm1irSKWpaQ1dOaCw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-1HapxDigPomq_9NDQHpkqw-1; Thu, 27 Aug 2026 04:24:02 -0400
X-MC-Unique: 1HapxDigPomq_9NDQHpkqw-1
X-Mimecast-MFC-AGG-ID: 1HapxDigPomq_9NDQHpkqw_1787819041
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6db77430so253313f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787819041; x=1788423841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=erCGkMBq6wNZzYxKYvBXkMicQIwmnQyBEnM/IZzuXQI=;
        b=dkstzukUbGDLRR0MGf6Kc3UxuNb9eGUDoVgzivRhY+54FCA4nDtLF623+6sj+UB9PR
         7jIpi771R06oxYEPlootW/nvFHphE8ciTKeNPhCSjG3YcbfF6XzmwqABxddK8jJZIRsd
         62cNIqgFdhdSwlvrFju18bah5cE8Gop7dsR+oTRnxG7kOQ27M4H2s/5PWG/f92M/3TrL
         +h5kN6JThjQ1rMk19mQgUxfYmEnNwZDqeymEdXMXOb8F8Jg590Id6AUvjckOKzBy+v5C
         +YhkW7LAQm4UJsugM2RH/VVrcK3xDTiomPpaStCW6HwNbvl0mkPrLdhIgJd9O0TuCaWI
         IHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787819041; x=1788423841;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erCGkMBq6wNZzYxKYvBXkMicQIwmnQyBEnM/IZzuXQI=;
        b=sJQLHOL7wkq5KUKHRoP/hueviXAD3is4WxRAwhjnS2HntiySikDScOWSGLmac+fRiu
         m+80lVgWnUff8/X3TOzV6xZxVRI5TSaF1qKGNauq50CGIETvUqZUt6eqlYEO1EeJuOrt
         27HyPo3DiAArwEfWjKqFoULySaX+xHZVmH0v8lzUxywSHZPB/2eHu3rFzhhlfpMG3ve2
         I5XSPOvIGYClwTOZhyQ3w9BY1rW7Z1guAXlS0fY4EYBeQjuXG+dJu8CeIy097S85BN8X
         /ibK/fCKMpGNwHL+slIf9vSfBSlAFI6sZkiwWTReHREXs0GyChE0Dp0aDwfcjXqobiSC
         oFIg==
X-Forwarded-Encrypted: i=1; AHgh+RoIp64FLCoSs3Oups7bK40AM0EsCRYI0zG8FJ2ajEYEaiDygK1OkhTUm44cmZb0rj7An6UWzLc=@vger.kernel.org
X-Gm-Message-State: AFuF++lXhRHLSeafEdSy0l1o7ioUQlSJ82Neqe2I8JskSQ23TTf0dskp
	lVg3uqobmhZ2yfjV3li5hE6U6nG3LNJ0IAigRUl50MI6rEWX2WWUgBjvPIrclVteMS9/KnqukLt
	LhllLp4k9i1GvpIHzUAYo9Ri9lfZYb/9DOP49qjX4OWzH8A8rWVcbdYYbxg==
X-Gm-Gg: AR+sD114+CEYz/kXhYqfFolb/VLD8SniyZJ4SSvt0M36BRM7y/Jp4yZGtNlbwDcLIO7
	taXasayvZYK5CpXiH93nFLJZTAQOYqls3XIOmRrX3d2AIR48Ipxj5lWFZJNXCiQgneZt9QUjAdE
	9NYuicIZVdQGWVM6UWwzeN2rKCFmZUh5k+06hWKRefCK2Wb4TK9TEsGO1NxEQt65f3xyR8LWYSg
	4Hj+JvlxJvwM39NqBtDDZqHXdzkygYoeh5tvqxDpfnZ4wwDKHpwKyyPySpbP2x0/cEFiG/ljMSn
	Bge2lx4TbL4xCq73/xo6neZjQEahIA0H7v2F3+Vv9OQt17Bjg+xDPrl1+U1hhqbSDNeUhlOR/rs
	foG3TP6Ezh2Fs1YxzP0peYbTH0c9KhLP9tN65BXMN+NEVoZ8mVx/TC/6QLdi48+JkgY9kn5I=
X-Received: by 2002:a05:6000:4543:b0:481:4697:a6b0 with SMTP id ffacd0b85a97d-482e26d99efmr12170102f8f.20.1787819040891;
        Thu, 27 Aug 2026 01:24:00 -0700 (PDT)
X-Received: by 2002:a05:6000:4543:b0:481:4697:a6b0 with SMTP id ffacd0b85a97d-482e26d99efmr12170052f8f.20.1787819040481;
        Thu, 27 Aug 2026 01:24:00 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279ecaesm7526943f8f.6.2026.08.27.01.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:23:59 -0700 (PDT)
Message-ID: <96bd39b4-136b-4941-9cb8-3e35c5680f0a@redhat.com>
Date: Thu, 27 Aug 2026 10:23:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] net: phy: mediatek: differentiate MT7530
 GE PHY from EcoNet FE PHY
To: Caleb James DeLisle <cjd@cjdns.fr>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 daniel@makrotopia.org, naseefkm@gmail.com, joey@tinyisr.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260827065930.2618729-1-cjd@cjdns.fr>
 <20260827065930.2618729-2-cjd@cjdns.fr>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260827065930.2618729-2-cjd@cjdns.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 8:59 AM, Caleb James DeLisle wrote:
> MT7530 gigabit PHY has the same ID as an EcoNet EN751221 10/100
> PHY. Differentiate by checking whether the PHY supports 1000BASE-T
> which is always supported by MT7530.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

