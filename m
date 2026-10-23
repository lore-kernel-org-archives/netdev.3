Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774128;
	b=ym485DUU9Ft0vfw6uB1HiCIJmz/dlKGXKY6GDBllMA33/WqSm3bJMLAl8ubTLy0GZHam
	 O4x05rRRfUdle+1qAuoxBCmcbcUHbudIzlBl/kcKWeUtH1hpfXAPjVORgl2SztTLKRBx8
	 1tPmGZzEMMPyUpL7ZPKiG3wjoQW+tuFaV8c7nJLsE9fkDOSjkCh96kkKg+Db9lLDYNqoT
	 JBvtElv8+XG1WKInhI2NMUHU5sVio60BnekpLU/FNsjZthBj29V0Ffk5KnLmJFiabAHX4
	 4jfufGHdAe7fnbFKIgfOCyFBMCltV7cuwwjIeQ9meMqmurbnI0Yzfgpe9xr1grm6S+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774128;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
	b=hUaRB6pQwYmmzMYGGE+8DlZDVx1StqWYe7XCofO4A/1lPpfxJlQfkLr1FTTkHPfBtKvC
	 ZpJiNArEv87hx465V7uaSpp1Qr80xq20pXVgbVUq9vv0keQWL+7adnjcrP6Fy9Iy6CZ0L
	 GGV7G7wKDz2GE/lIRirDHtviMH3q8ilLfbQUY8ODc6baDi+SnjX52/VgVWxxjbh1mys7J
	 iQrC5iJnn5FVkEkfTp84EvWINnxHsJMVXuLJlMg4f0lFg6Abb86IvJfb0thSqXR6tj1yG
	 IoYAorU68e7wH3ePbFc5qrnUBfmUsLHZrmWw0rJt3qqWS0pW8al1mHYaOB+hqeMhemg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gU82Iq7X;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BPTSbtP3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3612606A32D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3612606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gU82Iq7X;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BPTSbtP3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792774126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
	b=gU82Iq7Xsy1bpWiIWtNPit9g5SQIShMVBOyJwx+nwb+BjP3l+EB4PoCljAmCX4l/1T7dUD
	+6tTkweWJ8evAupHVvRN6kSm2boS84zitk73UcCxFYaXggpoiJzkpIUtJC6FUrJtrqd0rN
	IVMs4Kh2OrhM3PI9LV69RzWvXdes1A0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-MlPm-KssMrOABzx1DtiupA-1; Fri, 23 Oct 2026 12:48:45 -0400
X-MC-Unique: MlPm-KssMrOABzx1DtiupA-1
X-Mimecast-MFC-AGG-ID: MlPm-KssMrOABzx1DtiupA_1792774124
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c4445512dso978847f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792774124; x=1793378924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
        b=BPTSbtP38Ln26csJh7P5NEPySUmwcR/oqoTqdMjgeJkjJBOfGB8oGdKqWEV/5J4sYF
         tQZFeOyjtUZM17SHhTrADGwRtiCxcCFahBStsgRWDzu59gAZSm6ZlcRm5Yu2Acq45xl7
         bq3PxX/+PW7aigDWF5Ew/Y41SiQ5eh1FAZPOyWxn8w1Gu/VWA65StYbjUlx7LXNAMiL2
         dVc4MBmkMHysXZKAuM5sLu+e+Li2DHNMg1GPrnko910TBqQlXSEfXlp4m645oFcA27/y
         aYPiOuNEO1A0vaRAaMqukmjONYIY6oKy/O7nsOAiIQ1z9Yyk5mMfbT2W7m2P73WjIsBv
         7R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774124; x=1793378924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4yjbuyU9tYNCrKIyPpIJSh4fdlXELraeddszflbbg8=;
        b=GmU0uMlYdaDell5AjwHUPm15DCUdSTIgkJlG7eOndVw8SWqp/PNOtE3jc/tHVjrk9U
         8xmAUacazDvJ+NMTjqV2nkXHEi9Jtj7usbNoe/fMOnZAfO/+xbiDvhQ8jFKXXAk/CblQ
         SKCvKBFAivStvcpK0CCm1cERXUZZXUiJopJvkdF505o7y12ACB/m+Ip86xASY8ItqIma
         3AuB9Z/ZSviB9Gv5VgUBXozlaoqj/3SKWP4TMkuY9fZiwuuAKa8EqhqLuPK2laQpedRX
         daIz0y8klebUhs6jC69ZoGf1O9InpIYAoHsGD7ailOKZbu+HVxqrphR9WsAJFWGNtzya
         jK8w==
X-Forwarded-Encrypted: i=1; AKwUvBxCU8OHi7lex5tZd9FwWQxycLPf4sGkX3QLSK5Np1YzPh7K7DRRWPP3Lx+oczi66827tTwAypE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuMT+wq9ibxw+If3i1thR8Mi9Upic/orBUG/szF2z4hA5z//9R
	VjF60/oA0JJS74ywEThjb3WTVQziDwwhsb7dqvKEivwvMbjUOD8iSX9aM0YL8s9RmuEBs6uT8kr
	MkUXU6qxREWM2/2QTgS2sdjHQ7IJQVObqVquhC/hT5o2nZXD0fj3cVqh8mw==
X-Gm-Gg: AYBFou1CpmWDRBO3y1HRaMnwviJ23Dp0S/Grk1mysFtaIOLaaJvDTo2we3N/own5E95
	KTId0Hl5XKWNSl+xk0j3Zg9ZbdxAZYFxcG9maenJu/Gqqx3eX1BJ3s98Vo+SnskOUal4qdeFbo3
	eiJjMJUoys2LxZfF4PKFDTWPmoAkEBjGyP987KKaY4/3XlNDyjNQMPWOMCnn3UNkms5cBsFSi4/
	prTS0lJbSdByFi+OAXIJHyBQB+3sH8t9w/ZX7FOkKV3vqozx2qJxItGmuIopJ8o6Gu0ULVHLxu/
	0xlxH6K7SMZywqlPM+G7sDWlm50ztZeL/LxpjacYVNo0GeZe1UJ+w5K8JxMMIZFUV6UCmGc=
X-Received: by 2002:a05:6000:4026:b0:48d:eb6b:9d0f with SMTP id ffacd0b85a97d-48e385ac430mr4702413f8f.11.1792774124071;
        Fri, 23 Oct 2026 09:48:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4026:b0:48d:eb6b:9d0f with SMTP id ffacd0b85a97d-48e385ac430mr4702351f8f.11.1792774123549;
        Fri, 23 Oct 2026 09:48:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37c4b7sm1157431f8f.2.2026.10.23.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:48:42 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:48:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: Re: [PATCH net v6 6/6] net: add ip4_parse()
Message-ID: <20261023124740-mutt-send-email-mst@kernel.org>
References: <cover.v6.git.mst@redhat.com>
 <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970e2341834eadcf265fa7dd61a05ee305fdc1e4.1792687500.git.mst@redhat.com>


This one was sent by mistake. Pls ignore.

