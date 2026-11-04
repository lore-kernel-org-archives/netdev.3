Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783353;
	b=z6lT69BBjOW6rB7vcdfOHXCS2D40bE2dq7fHBwBbM+NxKwsoAHMJEa6ifxBl15G0keRE
	 I5v3K1BthoQqSS9BRGhIU4TO5sQVJIusMkyms1bhsDopuL/CXL/jzmSPvCMQS46WIhSJX
	 IUXTm6aAojMjpqBah8RoVpsU5O3SSeNaovxTeinOYm89r4UZMpezN6BTv3x4zY2gztOR2
	 wMkrN9bhd3af0MuyUcHBkGA86b7qzaYev052Gb86oZlf36P2xoBbNPmYE22PJpeEFCW3u
	 TyPghgdA50YPuhTeCStrK3cs+sNC5ZiBaMvVFNYbwesyqS6EoaMlkTqVqXO+jfWi4ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6N0dCwGYbaSifjtRcxiUXP9JeEw4YeOJxqoLR+j9Zzs=;
	b=5Gnm5dOAaAcFVhY1RkjrV0+KvdmIS2BdZ2j7nerbvYUi+qIW2aFZegIwb+VFwIXtwtQ+
	 6djx0bHEmcOB/RjaQacngvvj9NMO4n/Xsr9RfMFTTA5JFBKPugZTWgOFFhRoJAhRQ6quV
	 boRYn4C8Z9KYsnmNJjMRYB/pk8ThshPGHYNYzMmlHEbhFJn8+/iahKp5jYbxbXndwm13W
	 fG/3b/ZaFDLQRZuOs2QfKQp83J1NU7HMU0DGq7PbRz8j9JZd94+e59Nhq7DHHyBeNY2GH
	 XO06eZWD03Zo8F2CkxHAlfv6T70047D+c0GOckhFaTnj+qLAL1wQC3Gskuu2qy5anfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VFIuY8n+;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4E606A32F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD4E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VFIuY8n+
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so631043a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783352; x=1794388152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6N0dCwGYbaSifjtRcxiUXP9JeEw4YeOJxqoLR+j9Zzs=;
        b=VFIuY8n+9o793fjQfjKA7P/9zTDobpgrzq0l8UAw3pBk++/vGCLdxdIMTmaAjyT81U
         //JombrXujrMyVPoqHMHvcB5CsvUrosqajPmPGH8hn+nqyBuYn1UJuSANijZK6xA6iZp
         G4BD730Hd/WYprQMgKqyMl2/TWIEymIEK9drSSwnb8wab9W7IPUb/Sw0udoYAWa56o4z
         uhJdbagPEwieAE3uob/cZp56fQiJ8OnejF3Eh6VqY+KfDH+vrZ3EPxXACr8N2/32L4sq
         AHPa1STKngj6EdVfs8KZtBZ5n527Ss/lDcxnNXxb8T/iri/gC9heJwiNxtK5YZi2X9UZ
         3uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783352; x=1794388152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6N0dCwGYbaSifjtRcxiUXP9JeEw4YeOJxqoLR+j9Zzs=;
        b=k0z3simLiJxhh6FINLvcYso0ImOoevXv4J/rlvRVT9EjsM/actZ6NRLUxAr0Bt62Tx
         y2M3x3cIEaYfPxktNxyYInxVsaHFSmy9Qm3s3P3SZp4KCw/dGWpmpsRuR7vjVlMLLkuG
         EyNKbffJCis2iSlNfy5W21Uizqk1ICpt1vQBu0EBIVcLhEZv7JeFZpm45QWwpUzjoprF
         PR5jLYADrI62I35kTB/ItFIW2pC4t9dAaO+trps2MIzKoH3D5PSUVl5YZyGzT/0YWQR7
         PbX2v9Hm3SjdSptOU1lw/KBiOWcTB7cVYXvAQfmVrkLEVCHWzNxWitxF2h5Vw5P8e5u5
         4FTA==
X-Forwarded-Encrypted: i=1; AKwUvByNPtmET/fD593vpkwKCrBrLVgf9tiVeFKmUi3PSgCuxCMdSDLkmF8rP4xgqTl8JRcuEWTbU7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z88qCuRqavVE9jcsq+kdPUAycH+ztBn610L5ObiUGNmN1jvfU8v
	EXQ0Zznb5riERHfs8uYm4V2BIcNi6zRyJsr5lZYXdD298gWNpmBNGjxw
X-Gm-Gg: AYBFou0eFVN05WTTcxmlgAFxrrnrd0g0u9y4Fb4LBb/Mkpm/udclzSlzGMEtAwNuslS
	fvLc2HdUz4Q/AvtrfuGXCpdCmk1XOtFzqT4s5hNaSokmAbjhLBwHPhHe28n22UUSRFOF/1hfhuu
	ebqMOVXnSzsmdM79+vx99jbB+SDMkPT5hvKnnqo6M/jrIhsgYYTMV/HUJWOH3yPS0zCi54Bavv9
	IfXs4TIzN6pyaG0MoT24k6m0tMwp4/Ltc014hr/X9/fAC6IATDKK5jefBLO2Xe5paWGQ7LvY4WH
	v1yw/9cu+eb1bkU9eZ1oNIdJL9f8PrHz7wriQl+hWLq6aEprx2Sw6LZbcMsKDlfOmZOEU+xQns2
	FVVE6sutMwGbJ4akqmB5EMG2c96ckxMMFIzU2cnxNBKvA/WQCpkuAolgH3zFdWob/8/3WXVu6BS
	jUksYplLKcg1vVlr9mp0Mt+3QXhEmsGrNbkMDz9X93wcpmVfF9t30D+RqdzqwJvFOjyWEua9XIT
	kcCKpwh+WO93GNDj8ielDwQ3n6zGAFpy40FGD5mErXgBYSIDjZsup391oLAQzsKi14dqgz78vCA
	GAC31Qy1/XbhoDC5//H9WvGenpcIVYtc6lWa5Jqmg+ItTLvXMqF/L8pj1uU3mViol+noDabdNGA
	pQcV0yy87pmSsNuAXNc5bj4JhRI74MWYoN7X2NPXbmsP5d8MvOEIwSl69X+RNMwX53OkG/DPqEY
	3qxPU2tteZH3tma6LSsIX7TLglDt+5GIQ3lPIh+3e4r6EySH23rzr5VqmUvuJdWs/3
X-Received: by 2002:a17:907:6d24:b0:c40:4848:f7fa with SMTP id a640c23a62f3a-c4ca7a9fa2amr1338324266b.44.1793783351592;
        Wed, 04 Nov 2026 01:09:11 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e41da78sm48735666b.16.2026.11.04.01.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 01:09:11 -0800 (PST)
Message-ID: <e669a5be-a96f-4909-b962-5e55f160bd1f@gmail.com>
Date: Wed, 4 Nov 2026 10:09:10 +0100
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
Subject: Re: [PATCH net v2 2/2] net/sched: taprio: do not replay missed
 entries in advance_sched()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-3-krystianmkaniewski@gmail.com>
 <87ik36lee9.fsf@intel.com> <ab4a8b2c-0274-4423-8d10-04e7efb6c120@gmail.com>
 <874ieoj990.fsf@intel.com> <ff74c290-3093-49ec-85ce-0e2385419366@gmail.com>
 <87bj85wh0n.fsf@intel.com>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87bj85wh0n.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 01:56, Vinicius Costa Gomes wrote:
>>
>> Hi Vinicius,
>>
>> Just a gentle ping on patch 2/2. Did you have a chance to continue the
>> review?
> 
> 
> Sorry for the delay, just another minor/optional nitpick. The series
> look good, run a couple of tests on a VM. For the series:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> 
>> -- 
>> Krystian Kaniewski
> 
No worries, thanks for a review. I will still send v3 patch to
cover for everything you've found during the review, hopefully
I can do it either today or tomorrow assuming my local testing
goes fine.

Thanks,
-- 
Krystian Kaniewski
