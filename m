Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703478;
	b=X/7C3oOhhjmvIbe0qvKP2ELct8k99Uf56nubbP6WrcV8VkY8h+8pzl9lM1wQl9/yWSNa
	 2lIwMUHGQMPECRJ/GsEXEJZfG10vAwV8wGRv1JHQbv4RdVBNlnvE41jdXkfsWfEqzJwuy
	 8t9waR8KOkR5Ot/FEDyTV5fIv8qhvrHMRMy86Y63WepV59NGhA0a2jnRzWRsNSrWZ+tK1
	 PPvp4OkitkGWcES1ZclpTLm8h3OeVfdwaQEz3x+OMbuvAgxLUWrnU9X4ripbj4nP4d+x7
	 EItFMhHCCkUioN5c4kIUlqDTOJvOmy4kfomNhtWz4H1VyhDEV1WoR5kcSBaiZXhMIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703478;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=S1miyJ2KgpkG/3VakqMHUlArStntHgPFl3nSZcA3QfSddQ3ZOpJW4kgDtIuneKY7jE7Z
	 OayLicbVbVG/zm15fVrPTBj2uvm37hZxwmKe/XjTjyEHjEY70Svtux2+4q8o9uxaH+Cpu
	 y/shANXp5BDscUT4xIX0aYI2ngd2abnS6vjLXHgA0KWhJNe3249PBf8Ysiip0rMJEJ0hH
	 xXHpP8JjEiQH2sCQANcANM5kbNpzWgHVjWY9G2TtGgj3c0l0e5uz9EwAjqWQjexhNzI9O
	 7Q0krVFljZ8xuSdG5cIMHch1Da6HZYf74H6Sb5DRP51AwzxakaEwugFfW11L2O5Ixuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IR7HKpyH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061D606BF96
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4061D606BF96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IR7HKpyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793703477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=bBa7T2lOJ+4pF2WLhuJ0Y1S/bo5D48zOxrbNpkeP0iS0LOi67rlAAT3sznN229mI9G3Cy/
	kMYmP/+nP8amZ7BywKn3sLSxA80NwooEqQggcMYv7ZUw/iT1mPr2fOtMRvjlPCJX6AHSyq
	apDQurP5hOTmEwx7YKaWSiT0Kzlockc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-t2EIZSPbO32k_NPUM9D5qw-1; Tue, 03 Nov 2026 05:57:55 -0500
X-MC-Unique: t2EIZSPbO32k_NPUM9D5qw-1
X-Mimecast-MFC-AGG-ID: t2EIZSPbO32k_NPUM9D5qw_1793703475
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso2236520f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793703475; x=1794308275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=IR7HKpyHpsu6vhKrQ2umLvoyYUPBYAXMIoBY7nB3Guu/f+JDm/h4J8Eu/Yde4UqUyy
         pwI1kjp429XrY3TRPE3QkcTlZmhy+Zui6gkCSUr0mxWKOl0Cx84ul0mY4+Woz3AktlBN
         PG+0YoaN1x0c2ZvdoVXkJswZJWBLMQ9fVki2P5xN3O9mnjKYKzysByPpWC/U/XKpthB6
         sXs3P84hbEpNBy0K0rrBeDfsDY9s7oStI78pwNsWs2+xoSL/xoVBGNMKhz4a3a1LVona
         dDx0JUDNe679Q4woAXHDbi7QJTWRWXo/RLnFCuGFfmwG+qLUTmcf+81v7R3C0Mdfv2ZK
         aB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703475; x=1794308275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=xYd6rWoYMEUyMT+yQS8KamDEs8ZS8QTAAzpCTI5M3vDTIp4Xt+ZfFQbeyLJE9P7Hq8
         8Pn4l17I2AWxyHdDNE9cRrNNEPvLA6ZUdzdN8+aPfTIEtWFs7bDkRKzits+IeRPZ8Iwd
         yo8cKIAeppx/lzDuUcJCG9Njy4x6Qhlkyaht/CV9eg3btceDjC9XBzlvt1DvcIOJDOLI
         XFUyp99TnXgM5oGwpunPw9CYd8tiZbmvSNPbi516QjQPm9lQL3y2oVs3dReCBVoZKkqa
         bYz9qqoaNrm9j1OZ2vsfLqf4JsAicbfPHm2RAhzKdQ21OVtThmVgiJhO81zUuN6ZR1Nc
         1stQ==
X-Forwarded-Encrypted: i=1; AKwUvByKGaBXbfApIA0eQK8TMRQ1TAxNjjA5tuH8n5TjaptcpJNLouKCz1jA3F2xA/VuRP8QaCHjPd0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4dLgs+kZwLL2XUe1B+j0n94kwJtHcuxgeywd9NfyqQxlD0MYf
	UWeZDeusmyEiAvDh4Cl2MpptKryqw349rZ6TyAqEYRrCJWnirFrsoLMvHKWYmldoy1VjLNs5pXo
	uJgzYcRUtvFrC6bd8SDK/BQsxwhSvQleDKgT4sRomc8f8YZ66hNEJafUcSg==
X-Gm-Gg: AYBFou1j4ugvfYyflAzNbo+HHW0BO0RXwmIc3TMFpL+XzrByv9g/K4mTLrYpc04/VrG
	SGOd5BHCtD/0c2bVtOawt2RfwZWvluqyA02igQ0PnMYx1D1L2zW9IhNZfjeIn84q+0/xnqzedT/
	Fwn/e1YXGrA69Y54hajKqxmJlTvVJS4Q2iUYccxZgnoJC+o926zAMaN0901kGq0lY2T6a2MZNhE
	LXVHuws9teox2jdzqEN/f0eiVM0YazeUEY9ilQvLO7eI6bZRUhmKrYEI7YkNLyFEb52d1w9p9G8
	cnxc0wclfHdGPyGmJsTDSJ/dYNAQBGXO+n/mzPTilMRbkp+pmMMgGQu07cy/HpO+a9QHeVCtGr0
	yBaJW/OoOHi9gyKrFdUWnH2TJL+2DxrFLjl0sYAYDxQ==
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753769f8f.19.1793703474635;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753733f8f.19.1793703474133;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm24257782f8f.43.2026.11.03.02.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:57:53 -0800 (PST)
Date: Tue, 3 Nov 2026 05:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261103055650-mutt-send-email-mst@kernel.org>
References: <20261102122942-mutt-send-email-mst@kernel.org>
 <20261103032935.58823-1-fangxy@xiaopeng.com>
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
In-Reply-To: <20261103032935.58823-1-fangxy@xiaopeng.com>

On Tue, Nov 03, 2026 at 11:29:35AM +0800, Fang Xieyan wrote:
> Hi Michael,
> 
> Yes, same fix - sorry. The October 21 posting is a duplicate
> of the v2 I posted on September 26:
> 
> https://lore.kernel.org/virtualization/20260926160755.21485-1-fangxy@xiaopeng.com/
> 
> I resent it as a new patch instead of a v3.
> 
> The !len form is equivalent to v2's len < sizeof(struct
> vring_desc) check when combined with the modulo check -
> zero is the only length below one descriptor that is also
> a multiple of the descriptor size.
> 
> The diagnostic change is to pass the byte-order converted
> len instead of the raw desc->len, so the reported length is
> correct when the vring byte order differs from the CPU byte
> order.
> 
> Would you prefer that I send a v3 on the original v2 thread
> with this diagnostic correction, or should I drop the
> October 21 posting and leave v2 as is?
> 
> Thanks,
> Fang

pls take a look at my tree, vhost branch. if you want any
changes made wrt that, pls let me know.

-- 
MST

