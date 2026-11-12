Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481759;
	b=wIBAMzKuNzt1VTfcjMn8X92PStZdN2/IqWjSputPtf0uJxAfxRUl//R2bImDIdDtI1Up
	 znKlIRTFOjrEvM2QNM6H5dRVSP8f50Ypds1P7gS7JEw9YjFBDZ5OlP7n/ivLW3MclVN1u
	 oxCZ7Cl2/fzFmlB1WedbjdDFIzyvgFxdLhaHono/TmjCQibFD4SyF2ykpV2wqRD2FYT7Q
	 ccucOQgYQC3dYViQbHaQMP6LQab4MJ4IDv6AqdfyULkx6usnztOM6MgldBuz+0zp1N5cT
	 NgdiMGEHKw+4oUIUDC0+TsGMUWHKpFmuAlHQAnMEOuf5bMFNlhoGEbU2yFL+uc8fWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IffUWbVgejcXQC3F+05E+VTrz5GzU4svg//3Rjb0ZF4=;
	b=q7+NXh2JExZIrNpTHu2rzfxaSNIex3dYVJWXY6rTNH8Q3uKUEwGPmg5f8tGLAOzecQBX
	 /BcFkl1mzn03QInEcVE5X31mBy9ZnSKxJ/0/4ob32LS+63d4augwl3p9vsNOvM1xks8w9
	 QJgHHMgqyptvJ9a6sjPcJYeASiomD1JR3fmeHC5ybIYzxLTFrBIvw9GmSTlVXjQ4gI9zx
	 +oeyGxWey/Td35iQOYCO+8hcCJd1uZVLS9n7/ZDMwdvnR5GH+UOCbCDsEdKRqGUnY7/ok
	 vGnbvEzwhQZS/9bk+2jiIjjSMR9WKb4WCNzU9acVPgDVJG3awaCqLqHpABnIUdL6WAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aPArUoC3;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D203606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D203606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aPArUoC3
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49412eb1474so2492567f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794481757; x=1795086557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IffUWbVgejcXQC3F+05E+VTrz5GzU4svg//3Rjb0ZF4=;
        b=aPArUoC35fpsLAcHPQdPX3P0Aap6FebkY5PuLtTPbhXxSpJK7zmf0xsSZY7Vqvv1Uc
         ioxr61OHpPoQKjyx43F4AkAed5eFmu1aquJ0sKdW15uLP6uscwjEkVOH2S/AlUvl6ufz
         pdDmILORfObQH4eXpc6F25yDL7+fMDzax2NfVuMN+osprMP9nPIX+vSrNh2lVmn+huNM
         YeejSxuP2GWm0FzDlyoev3GIIIkMxlTk3AQQkmhnuRME05pFZistumRg4xDyvyJOzsKm
         QMczUK96g/Yj+8nK4ITqKjm3yQtfQftTj4iPvwvNL3PpedO7yI8+vcYPmkXH/tGXc6K/
         G/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481757; x=1795086557;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IffUWbVgejcXQC3F+05E+VTrz5GzU4svg//3Rjb0ZF4=;
        b=yeeD1AJHJzN7k32zdvOIwWF3oHOFdCuLHkiQNrP/UB/cz+LLN4PjR9+9BOyAnbHLQL
         s3fxbdRa29QLVgT+PKw+eM8Zw0PywGxrK5115jq0C/8HThfpVnT047hYV9SSy4lzuE6z
         Cf/gqYLuEZ7rmhUgDVpuENFA9R77m2zRHcQcGL8q5rPMbvRVwKcgTlEj1ChF34FyvzBV
         MUkcnJ06RoSB1d0MbrbrcncMdM9ZTAnJy7yKDqoJkz0DkNU4+Dpgr6eRSPkWeXXBfPRk
         HPSP+GahbrmWCueocNs3qVsVdvPnwdPR8LPM+Lu9c/R5b6VQNuZNKhnGZeb8AkJ1peNL
         tj8g==
X-Forwarded-Encrypted: i=1; AL+hErHKMRv9/fQuMJa9uTb/Kbr24/ufJcPDTda4MtpIYxhzN2IeYc+ELJiTPCC1dQJIoFWAcmhv+3Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/9EDes3MSZ580g5dbvXCb16nErNhzJ6MFW5inMzHnk+DGr7Dh
	22FTRgJZTin/IVxMcE2xqTRn9AF/qoFiQH53LL8/Am6CrV2gxiMLXGb6dsLm1oiAuS0J9RwNx0z
	kj2Tl
X-Gm-Gg: AYBFou25iWxxURnEneZXDr7Q0grasftlcBrUIl3eDhaiug7AGsiz/qTKEOwcMFUq+B1
	DVwtsWCFiob2Lac0dks2thWayR/FurDRexODlorTWy0dbGava6Z+vCzdj6IjGWCdAfFsvquNXon
	Mbivf8wJ9qM1M4RrOr/GZ6tQ6Wa2l0y1SlCNgDxadHLX9R7SDY3iGg5erpWqgu5ZyKqgIKLMrBI
	7As/+dMfGbY3q8nIwUMAIQvpFz0Iy4+G74jhzzlHtnuTQWdIyTV6A/FdGGhSZLiK/U8PJbx+ax+
	gvoYvYDBxaUB2C1+dXozEMMfMNTXdXKdgd6dZSnxiJ+kVXdBMtLLAW+brhb/eBGFQ8GFxYCvz5R
	rPh0OoxMj4IS2Gtt/mIIHHLTcNgiHMV3wyjifL+pOP/4oyUDlCg6xfY9Q4KsJlmeMnVHDj78Qvq
	lzwhhxhscwTFwwaVXPL71A6b62RMpCZnkinG5I3KBK9vB9UrJILy0bc+jlslVmgz7/v2Ci5AQJK
	AxcbXN5koA78T1zLSHGSXbH19kP3JEeKiRslifj85WJIHnvXygPMJ+oGAoFTFgv3V6K1IdMsWH3
	84O6j+AsAS27QrQzhYvg/vfRJj3IsWzvZXm0ea/GJgEfxhdn8cQ6K5LJWuWqS4iwtFWJxw==
X-Received: by 2002:a05:6000:40db:b0:498:38b3:55a1 with SMTP id ffacd0b85a97d-499c717cc4fmr9080408f8f.15.1794481757574;
        Thu, 12 Nov 2026 03:09:17 -0800 (PST)
Received: from ?IPV6:2001:a61:1383:8501:b640:909:5395:1fbb? ([2001:a61:1383:8501:b640:909:5395:1fbb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4982eedfb36sm16041397f8f.0.2026.11.12.03.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:09:17 -0800 (PST)
Message-ID: <5d30ead9-8107-46ff-a29d-8646b941a79d@suse.com>
Date: Thu, 12 Nov 2026 12:09:16 +0100
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
Subject: Re: [PATCH net 1/1] net: usb: rtl8150: break cycle between tasklet
 and URB
To: netdev-bot+sinfo@kernel.org
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261112104548.693456-1-oneukum@suse.com>
 <179448073312.2168702.13029326266334825765@kernel.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <179448073312.2168702.13029326266334825765@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.26 11:52, netdev-bot+sinfo@kernel.org wrote:
  
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

This is in response to a patch by Myeonghung Pak, whose patch
tried to fix the issue, but failed to, as Sashiko found out.

	HTH
		Oliver

