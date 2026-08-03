Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13B33A9FC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791507; cv=none; b=nvpXIGdX0hwVzGXPAWIrDx/zjT32ZfNNbrsYtK6YdzyvWMZuL/LklFara7sjCfpydDT1ANxbCLruDWM93sRDb4DSB0eWcly1JNn+hQGj53gIEpOzPVIsPE4fuPW0PQMI+spuPnbuxmlBHHlzqTOUG9ZzSlhUep9IVwWIRy/VzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791507; c=relaxed/simple;
	bh=v8gVHxmv+fGSveTvnVVvksll2ix8Rt6Vqv9khc+IiFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PpZGv6dCfpzFXYrBUAmRK1AC8m2RZ0N0jxIgO2ar4XVnUZdeNupwdKTj6oPwkFhiW/mBS+ZM6HFxK3iruNwnfDNOEze4ufqxMv4gZBvFU1zzQFs58md2h4tBMli5sLckFRjR2m19e3slJdka01UW8tW/Mu7lEogl+ZTPOlTOuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHVr/ezs; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHVr/ezs"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664a09bc459so4846333d50.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785791504; x=1786396304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1IJQv5N0Y5xSpVGwoqcSQ38bhcTBZB/1Y7LMvGXYgtU=;
        b=nHVr/ezsqbJLf9EZviIDwdCKCPKZne0uwPZlcslWeoinDHMq/S7HAsLq75ITKGwSzz
         HrHp3JVk7yJFAb4ebtZSnqPBw8WGfUiOUdPU6+keYxJCmzlfiaXkRZsglLqU1EqmNWHO
         PbRREPyQ6B2CMCBOv0rMfKupx08OVkKuVpn5VKVQZtHAdTnNh/U/CLhIi5q9jrGF/+J6
         YfmMN1jUATodhGFG7hbS8f8JFKctc4bZIVswlJkNyh9kon+a544YN9NkRfx3oU/B8Dtk
         +EUQh2VF7dx5h73Ng1vCg59WuqwyQ2JcN4nfXIwEwYG/GTpMnAWmage3CrYeyRNS/cLn
         x1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791504; x=1786396304;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1IJQv5N0Y5xSpVGwoqcSQ38bhcTBZB/1Y7LMvGXYgtU=;
        b=ekfgTWVYpqQkYdbasMa8KZZnFUj6cs46HXd2QnEC7yMscTyGKlBgT86C3BMfUtchwP
         CHnXQYttom/RXPiCranJL7pHfHhhhXtb9sHUw+m0Ja6PzfmZiIf18uX+W8UXuJxyLWWO
         jsVnvFy1Qlkg6NUFXXtWOKqkj0Kre24Yindrtrl0riOVtzAplfpxVgH4D8o0we1TE+t+
         ffxWTbTKqM4FyeTkBGYmed6KiildXgPmPQutlGyDCBxnGZCHodtNozIo705XsFaYOHT9
         wJLfdEQM9OogLomeIbOiyMn3jdrOsFxXSAzlhToBMGMBoToAEnOyIvmX574t6p2cCkyp
         rPiw==
X-Forwarded-Encrypted: i=1; AHgh+RqLVkYJz2Czw1XqqrrzOr9m1Mew2y1SXvei0ZxrhHCGPGykzN6YKjkVJGJozARtuGHd6v16/NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQiUAlEALDLBD7CFP0rYtdE8cimdRKMBX+MTDWX7NKFTaBvgP
	MrdY4HBkuzdaRM7zFVBcp+OHQJNb20mCDFb8EGGqec87lj+H7c0uo9oR
X-Gm-Gg: AR+sD12gQ/IG1J990YLHTt2lVY+c30GK5et1THMHLr5T33Y5vdpZDz4c9+kbLJDwm+m
	aiXLxPjr1Ofeo+b3IvAL3STEg4/M8VZ/EShqaP9nOFfCc6p+4ZaMeqTJp2gMtWL2VZ5G5L+pVca
	EpzU6KtNpsHCOsIaEWZkdL00zh0nUnomQcqATteOHOEm06IsBlrlfU/ALTwozVPvea0bqLrvZsa
	rPzLGqz+TnjVDo+AJSOODpM+OL0NjBEsHjNpC3sywuguUYJZHmQPzjaYEKuMdIN8ipLinUHTr2b
	pypiGc9CaFiFWsFBq3E7jQkDhQmM2kVqaGSB49k7ypAenpo2STtoQ9DhTPRXKUiNOYyE3WuOvuA
	bf2gv9W8ef7wLiidmXXv2MrQ3YC0vMGvCmq7lhQM26M7mzDU/LTrKncgOZTZxTlUMH/2yKbWwgF
	TNSQ3IuVRqiOU68JB7NdSUo2pTjJ0ktqgt5r4FMFv0J8FfYHKOABOtWTisBAZ1m2GmXXlcolzEQ
	fvmrt9CYbm004rYmzZ6TeZ+4GdICLl4xbZa201hfr0aDio=
X-Received: by 2002:a05:690e:4894:20b0:669:3fb5:d084 with SMTP id 956f58d0204a3-6694f0c3ff8mr10414282d50.24.1785791503877;
        Mon, 03 Aug 2026 14:11:43 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669490248c6sm6341963d50.18.2026.08.03.14.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:11:43 -0700 (PDT)
Date: Mon, 03 Aug 2026 17:11:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.3b2413bdeea01@gmail.com>
In-Reply-To: <c093518f-0b9c-4b1c-9587-ebe487497dc9@intel.com>
References: <20260731103137.4000876-1-willemdebruijn.kernel@gmail.com>
 <willemdebruijn.kernel.2f2bc4b192e45@gmail.com>
 <c093518f-0b9c-4b1c-9587-ebe487497dc9@intel.com>
Subject: Re: [PATCH iwl-net] idpf: add missing cpu_to_le32 in
 idpf_tx_splitq_build_flow_desc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tony Nguyen wrote:
> 
> 
> On 8/2/2026 7:31 AM, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> >> From: Willem de Bruijn <willemb@google.com>
> >>
> >> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> >> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> >> field in a single operation.
> >>
> >> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> >> __le32 to ensure the fields are written correctly also on big endian
> >> platforms.
> >>
> >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> > Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> > 
> > Forgot the tag. Apologies.
> 
> I see it's for 'iwl-net' but IWL isn't on the send list. Seems 
> straightforward enough that if netdev wants to take it directly, it's ok 
> with me. If yes,
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Otherwise, could you add the Fixes and include IWL 
> (intel-wired-lan@lists.osuosl.org) on the send?
> 
> Thanks,
> Tony
> 

Oops. Resent with both and your Reviewed-by. Thanks Tony.

https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/

