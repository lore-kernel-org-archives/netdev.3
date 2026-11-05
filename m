Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887042;
	b=mWulXCB3fgPr+aLtKa4fgwrLScclGDNHINQbwjwgIxmsFBcUO46Y27zANH2flShaO/W4
	 MIdG5btew/bHVtXx8YhHSdoD///F5aJwdNOd5n+vMXK1F0uuBeTKhtj/0i2/c0MPpRR/Z
	 YtjEnHqXetJqC6Yd+l7/NQ6cacmglDqWN4RWhe+oQzX4nfdncX6FOsZTWPPaPJPi9hQhU
	 YIewthfgu6ZuB0ZJTY9at97CgwExfDt6GCd4EgiLxOMyLCvqwFfv8BzVrjwJ6Y5a/A4ER
	 Uyq+pmDvkGCuGHfr0+R+ZFKyZ9/A+Caa1D32x/0XMWDtoipqdxbug1f1utcPDc41d3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887042;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
	b=al2mVoiFwkmAY22wRyB94FS9PvgJ2X/lc8PBjp27CGTeCU+4M9Bzo4HTP7SSlmpsTvBH
	 v0a1MY/BJXkLXpCxEe7Aywa2AJ2LLfaGFRVEjYoacYXmcCqdZJUir2Ac77Kik245HAGAe
	 MZ05pgPvinGaI07X36j3H8Yh/X2jQ3Yev3eizxZpPBQys7py7tmWSOBVnbPpys5e4m79D
	 bcYV758I50BR05lnBIB1UPyfyCSC+EtpURr366tgPZQvVSsgH61mKjFtUXmOIRVvuM8s8
	 58eicLohKQ30iBXiWLPCn1Va/K2XRWmNPJocjVglm/MaQyyaEFqFkKB1S8mNC8aO+eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="R/WL+4qx";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U2Em1hJC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE0606EE90
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CE0606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/WL+4qx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U2Em1hJC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793887040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
	b=R/WL+4qxRVGSNMsUvHj3KhfGQTljIUNgBbzdebtSvv7V8MHqaesQio7Dja1shp94xzElgU
	jJcyO0XvoZqknYBclAZ2ctC8PWKfdkoLoQotO7QddOGgUYehTh11rbzLAURpZHl9P4kxf6
	knaMi4Q90Zvfvdt4Genu9w2KPj+fkkU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-6Zv2HeXnN8-7GAiPsv1Dpw-1; Thu, 05 Nov 2026 08:57:18 -0500
X-MC-Unique: 6Zv2HeXnN8-7GAiPsv1Dpw-1
X-Mimecast-MFC-AGG-ID: 6Zv2HeXnN8-7GAiPsv1Dpw_1793887038
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-490c69dc02bso1130426f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793887037; x=1794491837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
        b=U2Em1hJCFVfRXkgj9mzgfMQoYYzaBAJvSWu17U/Jr8cUWtBJp+eeHEMlD1FpI/JpvB
         kvt4QveGVLJ9kHjXFQ8xpPb0dF1AHrA0CyZP7bTme4ixhVqz1G0qPeOZ1RX6XsypOaKh
         84OGkDCFItDVuyh5kfk0JNtYaFVL8Q/c7lW32EQ+Nd653Men4v/kBsU5LLk3c25DQVhM
         fT4A1rvarEMFqGNEM0x2cf51xsqgizYMVprOknxjcE07YbT2xflEQ5bUK9AkDckLwZ54
         tIOOaUmvnEfeG0bn455r6UoGyU99yuVB32grQvGSZdbelD9/dYlIByqIUBDzSxc+Wv+M
         tdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887037; x=1794491837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LugeZGb+Fl7OEGgjSES9UdL88IWgFCStcMs3asT+ykY=;
        b=LggrRMnvYIvUTxDaWekpz1rmHRFIM8TZ5q2cjEjd6fq0L1AZSN3jAxz1U6Xcy31roz
         Zi6041dekqC7lQH+W4wL5FidbsEkKDOZS8uj113Qjj5rD6yqqI4AQnGiM56dP9EmQTjp
         1bZoZzaXDBNE7/9cRwA/iMLKkJuqQVDStf2PRSP+usWYtLvfPbHfVt27y13SJTlDTVny
         thJqUa0NsuS7kA59zdVcnVvv8PikgX47A9mAayK0Z1wrxCTh5k/lk1sCO0PcEb9/hw7N
         tpjCUfsKP8hLAuofVgM7GrMxbH7kkA/EikFmxLgcMVfocXUhdHJt3X2JImz51EYXNGLc
         WCeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxV6fSN/rWECdxxJjNs1BxVrqhUT/+OUX7t1HUtcdFxSRkOaSEhbbrcdLc8LCW/us8TEoNb8Bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dUXcUxQJe+pAa1mm6Nr6RtgLAHwxn58fmi7P0mrvYvKSASKN4
	epvgOfUSk8/M9tmHpH+4/MBvwuRCC2iMOO8rYJXSyUdONBTPnEY5GsvOaJ62RVysizyVdff9oTp
	TDiR/bryOcBZyrI6JM+LrgUWK6WZf+hbPghbv/hSV/r/BMrz8fhzhq2UnqQ==
X-Gm-Gg: AYBFou1uOGVpdtJin11k/fV599lEgDyfuy0n6iHX1OVm2s+cyRHwsJZ7hcojqV956sp
	f8XcCrTFn+5uya0+w5u8br5lqdc/m9OoNOLfwuJ4l0q3pEhz5ivxUkemIAlGSvofpC8Ik0BZWx6
	8Lpn1izOJVZjqb2CO7zV1H375SCw+kBc2nny166RE1dRBBjjJUtsXoGpNK6YLooG/5RTa2D0z4+
	RNf6v2pVj0PkI+dWUg4KnZpX2A3OHDbSc5+MQZuFf7X4+1hkua16YXfdSC352t0ASbg5N3Xi8fT
	GmibtyXyaGFF8ACTzbMCq9yQ2CQNMMNV+/duqyOVPORYTBINv/3tWsQgFqFn6dWpFSsCsENNvwb
	MrBtvElNJsOFbLYR7NAhAZ/BDNsuSBfFkvaXxdo4H+RE1j8WzXxaVBaV+/FmTmsQB7tuQS5+4oV
	Vxc0pmRmOPuabC7cT5PStQ97JAlW2CbZBtrX3eAqQKbh8=
X-Received: by 2002:a05:6000:3c4:b0:491:273c:9649 with SMTP id ffacd0b85a97d-491273c9731mr4515071f8f.15.1793887037382;
        Thu, 05 Nov 2026 05:57:17 -0800 (PST)
X-Received: by 2002:a05:6000:3c4:b0:491:273c:9649 with SMTP id ffacd0b85a97d-491273c9731mr4515030f8f.15.1793887036899;
        Thu, 05 Nov 2026 05:57:16 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed45d2bbsm10667066f8f.33.2026.11.05.05.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:57:16 -0800 (PST)
Message-ID: <be1607db-4d7f-4a35-b1aa-0b0c35220407@redhat.com>
Date: Thu, 5 Nov 2026 14:57:14 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpaa2-switch: fix port cleanup on probe errors
To: Jaeyeong Lee <lee@jaeyeong.cc>, netdev@vger.kernel.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102071310.3004332-1-lee@jaeyeong.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102071310.3004332-1-lee@jaeyeong.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 08:13, Jaeyeong Lee wrote:
> dpaa2_switch_probe() reuses i while probing ports, adding NAPI
> instances, registering netdevs, and unwinding failures. Consequently,
> the value reaching the port removal loop does not always represent the
> number of successfully probed ports.
> 
> If IRQ setup fails, i is left equal to DPAA2_SWITCH_RX_NUM_FQS. A
> switch with one interface then causes the unwind path to access
> ports[1] out of bounds, while a switch with more than two interfaces
> leaks all ports after ports[1].
> 
> If register_netdev() fails, the unregister loop consumes i down to -1.
> The following port removal loop is therefore skipped, leaking every
> port netdev and its MAC endpoint reference. The NAPI instances attached
> to port 0 also remain linked while their enclosing ethsw is freed.
> 
> The issue was discovered by a static analysis tool and confirmed by
> manually tracing the probe error paths.
> 
> Track successfully probed and registered ports independently. On
> post-NAPI failures, unregister only successfully registered netdevs,
> delete the NAPI instances, and then remove every successfully probed
> port.
> 
> Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
As per Linus guidance issues in error paths in NIC setup/teardown
do not qualifyfor net nor stable. Applying to net-next, with stable stripped.

/P

