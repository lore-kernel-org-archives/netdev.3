Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68903CF047
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363708; cv=none; b=uka2C1mTaK+XSClkPoC4HvyabHD9jduPJMcezwyafe8+kMHOOpyx9z3rXRsT76uDhaI6eqB05Q41WTdTOwPjWZy5aQ0g9T18G/X3AT3b1dUcuKoSJnyBNZk4ntlKa6q223qMjTOd4BzduttmA4gKn3Xm3GqoL2abNKggWKt0Irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363708; c=relaxed/simple;
	bh=59PT6rbU4y6QwPmgwDv+vHQDeXEZEP7P0amDCOaxd0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvJjKKw8g92t6TgEj976XQ09LC7cHeZeKLNeeYhWlvJg68+yuJFtsa+igUvcuPa7hmQ2AcxbB8HqsqFlDXwaD2fCIwiqIZIMSzn0an7U9Gj73osh3yxZn8Ni33Uipk+jZJzi+690qoBm2FWkQNCXtGH6EOIjqTxVqFFXHWIPF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSz8NfuS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSz8NfuS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so1109695e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786363705; x=1786968505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rM7fwhth577JB5kWDfukkUHPix4kNnhkobEipbHGSH8=;
        b=BSz8NfuSXZ62yS2N6NjgU0+AVmQwBmsyZ66NZ8NsUUFhQRnq7C/uk9ppIw8IcXhNUw
         8KDxsIndCd0k96o2sfC6wYtzNjmtfU1fZ65EJNA/eEpCf554bXZ389tPRECVZbQ/Cg4m
         2awz75+c9/GolgtPCvm70o9dJoNzCq5Upo0nS9POIi00nFiqcx0dw8F1FYOBMDTa6WDD
         3uoZQ39Kl4X6mJzERsZlt2punehhExqRXU57bMcjvmDcP2/Yz7hRnXfcE9aN8MCw2JIM
         ak+QtPRAo7TJMS6A83Ptv2XchBA8+QxOFRZy5Fk15mCQjW9SN91s+rkMQ49u0ZiwyiLD
         U0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786363705; x=1786968505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rM7fwhth577JB5kWDfukkUHPix4kNnhkobEipbHGSH8=;
        b=lduL0pj69Q0E9Ok+eELHffJGQpORrHG3oal2FZElYu+zVCuzVrh0n4eRse52rE8Yhc
         Wr6on1Djvy4oD7DpYA4lj5Ti2iBVbXe8zQ+UdEjo1diB/EfomAB3fvigoXXpa58zFFfF
         0NXl7XjCY9pa7F6ZDLQgRfnefMjTaSh7CKNdAvAThAQSA5HF3sUdip7SxGSKNuQCuPrL
         K5RvV+aIBWZjR79TquvqpqqIrRVeNW/KyRuP6xYePMw/Y3Gzlch6x04HdHLCbc0YSd3g
         sGZtuM1yFX9oyUQ+dCYDuJmc3+sopxcIOEOLS7KxvNRTeB84tEu6kHTj5FFlUFA1Cc0l
         6H1g==
X-Forwarded-Encrypted: i=1; AHgh+RphbIySs5o4ybUvjTXlS7lf8RK/brMXXZZIA6X2n+j9bMRbvJhElEBXgvWO13UPvxQANE1PkSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvlcBQI8W9UecfQtUeo4mF4iYwRhEJnah9Ctgkd0rSifa6qVIs
	1k+R0LO/gkin/OxZmAyT2PA7artWw/YePm4UmmVEW3y+oG+z4g+2wKYi
X-Gm-Gg: AR+sD11oTB177g8x0gr7qMZI6s7tCAizUuiYuJYxbmUIx+Q0AvN21Di2o55COlLjE+8
	l7juSQdARLBnxhXSLhsA3Tx0gUhOgby3SI3VLPB4aSZ17mZuWbRhXzMB6SAPsELomJFXmAE2P40
	wYjTVMct3PtRfhi2Kdowq9m+cMGx6zuk0I6F9FjGM/HkFAOIcQNsNy+poZl+JI2apcsGw5N4Ern
	Hbs93dh80jizYRx5IEtMtZgAqF90VTTdvnYsar1o0+sTfT/lmGqOah3tKxElh9qZtBiaTEskmuX
	MNGOmUMuDDNShuD5y5MB5dinLetAS8IIXEcRRlxl8hW8f+1tROa8BRRwS/pgI5wglTBcCq0EOUv
	hX/zeVSM7+sXCApsqiVnCGGwfmTH/P9iwJJv0J2lrUOksQ7B/FKo/J6Ca6G9QmvpkbFYXTwg263
	VnMp53DLjbNt2E/St9+Ye0kqG3Uj1xFOTiA5DNfoKqlneN+fa2
X-Received: by 2002:a05:600c:3b14:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-4995b0f077amr172795665e9.1.1786363704877;
        Mon, 10 Aug 2026 05:08:24 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145679sm33009417f8f.3.2026.08.10.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:08:24 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:08:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
Message-ID: <20260810120821.lykofvogbrn2y2ps@skbuf>
References: <20260806073119.387-1-strst.gs@gmail.com>
 <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf>
 <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf>
 <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>

On Thu, Aug 06, 2026 at 04:39:00PM +0300, Semih Baskan wrote:
> Hi Vladimir,
> 
> > But it doesn't, at least not in a sane way. If it still only accepts
> > those VLANs that have been added to filters by higher layers, it's not
> > VLAN-unaware. If a solution is not found to the problem, the driver must
> > reject operation as VLAN-unaware.
> 
> You are right that the port is not VLAN-unaware. It cannot be: the VID
> lookup on this silicon cannot be turned off without the ARL loss from
> the other subthread. My mistake in the previous mail was arguing around
> that instead of saying it.

I understand from your discussion with Jonas that with the right IMP
port selection, you do get frames copied to the CPU even despite the
VLAN table miss. This is more in line with the expectations of higher
layers.

What about VLAN-unaware bridging? Can packets with VID=100 be forwarded
autonomously between two ports of a vlan_filtering=0 bridge if that VLAN
is not programmed to hardware? Does the behaviour depend on silicon
capabilities, or is it the same for all switches handled by the b53
driver?
