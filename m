Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08143DED4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084203; cv=none; b=XXb/n+vz4DeB/kLg6sjDrjmLuRpPiVPgHPif1FZWRuH2ZXs1FSTsaqaTaU3m5C02LDKUkhjtCRqCComJLly7yLb5ubZQ1Oi5x3bBSNprjxsHeSKjHj2yF2x3KS70BixAK7+Hhqd5r0vPqx2dBKIAezfN5+PY0mZwDSpnsYjZnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084203; c=relaxed/simple;
	bh=CYx87CEfR4uqo0EdKxZaeNEoOSY8JEECADRirN2DhDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBfUcebSsKUenCuqFYojhEKJdKhcQZxEfBOwN5vmQflwTvOrliKLGt0bc88anuLi43kk9nKXp59Hkgcwh/C4lUQd25BETsm7gw/IbY3CM8WjmPVD22Xidtcvc5Jg6f4lPaOJ9Z97MnCyt4EwBqWFcDuPEKu9YF7GN9gZWIaQ6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qpg11n3h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7MUDIU4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qpg11n3h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7MUDIU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790084201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDXjlNk0ngo/R8fuvqVhboxL4miIeE6je51J88+F1rQ=;
	b=Qpg11n3haG4Jz+v6V5JAx2rlepppwqqAAdw6xxn2uFJS5/qdSyKtVAWMoFW9llyn42MlNT
	4Kn30ontNcdE6ZwA/3FnyU+alqzMy3QgZiB2Mc8Ha3UhEfGYON3q+RgKbHLWLYPOjZz2ZK
	vPl/rpdRdIYfXSn1NHuVoMpZBwS36zM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-jlechLggMqef8YBsYLatUw-1; Tue, 22 Sep 2026 09:36:39 -0400
X-MC-Unique: jlechLggMqef8YBsYLatUw-1
X-Mimecast-MFC-AGG-ID: jlechLggMqef8YBsYLatUw_1790084198
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c294442d71dso495909466b.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790084198; x=1790688998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MDXjlNk0ngo/R8fuvqVhboxL4miIeE6je51J88+F1rQ=;
        b=B7MUDIU4oQUe29BhwmkRxaym59m1N1uuebtWHcUBEsTw+v+UeDLH6vah6mzAmyuaFQ
         Biaio2zFSqXm6x7hv/NyuaB+kABqosTamygxgZEG2S7fxIiI/kM2aJlpakYa2Z1Olyp1
         6dbpM6sMMIBdzrN0TS9u4X+z181huLofW0vy0U5hx5/h3/ZHwodjP+NYn/riCRzceDTx
         zMiRYrMzKY3HaEknO2Z+VyRd/5yiDyjeXVDXi5nWuZk9GJN/RYGkpR9MgKmGgOxqKDcd
         vU4l33CMyF5xiH0OsfFazOHamKAfYrIW/gAx4cgR+AlmJkf5UdQKmrxPnLR88ZUc/33l
         h4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084198; x=1790688998;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MDXjlNk0ngo/R8fuvqVhboxL4miIeE6je51J88+F1rQ=;
        b=bmC2xL6e4Nh+psHOr/SNi6igibQk2W7vi6Fa5O0c6RvNs0MQXRKrNPNZCpb7lQsmCM
         x1AU+ZKFndYsvVK53P2Mr4HDzgJpOVKU/FLc4/lY0L1MA5FrJNeBFmtbI+qLLh5OZkxO
         EkiHWQS8UH5gAESdsRvmd8WuwSg8Dsi+lPPsz76/vUtuY3pkZHlabCNtRGy2SW2BAveB
         N6gjUvPLQ5CO12l4ZEQEn9p+M1284J96MzZCc/0NVJiDY6nVIaojwCRcOEzgSnrFTkJc
         G2qjuRrX6IijMu5gCgkyGdstTS9Mo/lODexG7J6Xa2ePRaxY0teUF6ERZswXAC/cxPyH
         0NhA==
X-Forwarded-Encrypted: i=1; AKwUvBw2YiR7vjZphRo137Tp3yu8PRZ8ZdyoxVoFsGs9WjNits5dT4XylTclCsyw740ApBXD/IhfNo0=@vger.kernel.org
X-Gm-Message-State: AFuF++mnqeZUUEgZhPje7oxtlHkVMwTMNRSYuqxlUygm9hOrCH0J6QYP
	Pw/B/kie3lE2ieXvAvzVrjZ7ciHCRJKaZD89RMFhS9aO+0g5nLJ+JDhJNBbd7ndCJ5wuGYqpC7j
	8zc2eLkgCiCk0IBj74bPPoUrIcYwk1vCxmnSVqdhVU6nlZm3kAPaQX3+wog==
X-Gm-Gg: AYBFou0TnY5Y3SyRQaLmpZdGME3iONoLDJXgSdtzNx7w+C7Qnq91WupEL0LcEjhYpfX
	hfuJb3I4hfqF/wFlta0un0JphOwyKDvZEo0K6j+YcBHZbdaDbCGakbyiVjTb4e4Hw3wL7S/jCNE
	c/e412xaGuufjtWxwt3bo1UctHf1km61vCAvk06zZV2myvmD1/RH+JoOfIRkuTVUWoX5W3YI4pa
	gxTj4J26OX9wbH2YE2MBgJRl8N7ux9FFOpi6PKV+1+5orlxZTqFCygA6wn9IEA7gjjxuoY7uuhr
	Bedck0NFG5Nxp1wpKysviK1FrDqE0LhkNJirV7BkPso2o3Fw0UQYv+eMQx+BOfNJJpqC593BpId
	7+A+U/zYpZ0dATq8nGWTJCWgREvXaMmOAqQ77BAT+Ng58/7CNQeUw9+uj3wfzHA5OxE/hCFiscQ
	==
X-Received: by 2002:a17:907:3c8f:b0:c20:af9d:4533 with SMTP id a640c23a62f3a-c2a15896523mr1137713666b.19.1790084198431;
        Tue, 22 Sep 2026 06:36:38 -0700 (PDT)
X-Received: by 2002:a17:907:3c8f:b0:c20:af9d:4533 with SMTP id a640c23a62f3a-c2a15896523mr1137712266b.19.1790084198030;
        Tue, 22 Sep 2026 06:36:38 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c62555fsm86995266b.53.2026.09.22.06.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:36:37 -0700 (PDT)
Message-ID: <164304b3-3324-45f1-8766-536767e7b9d7@redhat.com>
Date: Tue, 22 Sep 2026 15:36:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] rust: net: netlink: validate attribute length
 before casting to `c_int`
To: Sagar Taunk <sagartaunk@proton.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Matthew Maurer <mmaurer@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918100016.100988-1-sagartaunk@proton.me>
 <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 04:31, Sagar Taunk wrote:
> Hello, are there any updates for this?
> 
> Also, I wanted to ask is it fine if I keep fixing stuff pointed out by sashiko for now ? (I.e pre-existing issues pointed out by it in other's patches or should I ask the original authors of it first ?)
Does not apply cleanly to net. Since a repost is needed, you must
also avoid empty lines in the tag area (i.e. after the fixes tag).

WRT sashiko-reported issues, beyond be aware of false-positives,
generally speaking net-next is the preferred target tree (i.e. no
or very limited impact, very old issue, etc...) with no fixes tag.

Focusing on high stakes changes would be appreciated.

/P

