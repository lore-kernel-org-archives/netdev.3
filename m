Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77A30648C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929474; cv=pass; b=VZwK8cMx6PRK/C4dGv5l21L1L1UhGW/ku4RGbbs1nSfwgdZEsZKMuSmccF6Eew5Kr8+UDB6Yxby1CWaIZtRKs3ouMRC/bJWTa3Jp5fLauJjYYyAciKP22pqvGL+b/KRc3JxnpG3qsUsPlxEqKhKZ+miXYVTkDgj8xCMoA3oLUfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929474; c=relaxed/simple;
	bh=SHMlaR7e60WLjZys1KqBq2H9AqQjLlKM6AeYANxxwuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPfdsZqbY2fkLYg1x3VCfOek62MjKKWncEUl1AJCGFFvX2QlK+yK2uTPWcNNj5AGO4vKfTZNLpVOCdHxA+5uXjTTlP4eOu8wK+X5KODfx0hSF2aS+RlWNU9b9qvfTkd7wj7ydQcxtPvjZiP9E7JbzVx4g6x1zPd9UJqt8e40ppI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsoNSKSN; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsoNSKSN"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc48fe04342so1937039a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788929472; cv=none;
        d=google.com; s=arc-20260327;
        b=fKCD/PUuz/B8P2YAsXhLjOEAp9yq5OxXUI8X6fpZFDd699ZBA2TTNtYUZwcolBmNnN
         zaQd1RTEkoDxy0iCL6IXk7xapMLJTvpVFw4dDJQeJcCiEMeBlv4AQhGfIn6yZeqBFXFi
         fQdS2s8MnOOMP0BnRn+0GumblbjsEWYLWFVVwbEia/NTsXKq1TaDwqVKZIucq1Drw9KY
         3kbiqsuEwoWO6o4B092O4FjCpl6TvC6Ovuzv25xmnuafhpMr9U4UkD5O/FzqmMBQA/30
         6CQwjtLhVbE9VXjXwM8BW1Ne0PZpvIFNxDqBjJe8DvdwKJ9lCvUl/9+5YE8aa3yEvK1N
         4BSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHMlaR7e60WLjZys1KqBq2H9AqQjLlKM6AeYANxxwuc=;
        fh=PRcvw+NjfaS+z+0nNvI0LQtTD9fMPG3UryI3Xe5ap2o=;
        b=W5tZFYBsL5nFWT4rAolom1HJhgb8uFX5Xu8u8XpnRPYgIQe5quVg2j0X9quyi193hh
         AJ7jZlFp4PmtPFjt3UovITB9bjz08uN5yaVdkrehIKvoMtDgXV32mioldraKbGuNIh2d
         2WZapdzBG35bP9CfQ869+OV+ExznySVhLOHOZHhhUTMU9AyZHLX5vkY3R+oYWvj7KuEv
         kXSKX1qoG344Lej0B6y2by5VmjGt8NT2Vjr34HtOERbmlQx03vKNg8Flgp+4RjyGiWyo
         ixwJp6ObkP52pAAN9Drwmy4ZXKpSkVT0yGviw9YTtSTR8V844AZIeC3F1eTZMIAMmD60
         mY4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788929472; x=1789534272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHMlaR7e60WLjZys1KqBq2H9AqQjLlKM6AeYANxxwuc=;
        b=OsoNSKSNUvIVuZsv41WRcdJZbgUoxvytus33wAXJxKJBa62O1EKNGGIm7jtQ1rNfaM
         9ygLEgQRvPnFXmGN9PO08n/zAuaLWLC9k3hnwwtqQkXRWfChQ44Ug/ZnffkPKya/S/fr
         usx9ff3cm2AzLKJCH/u44yNyVcbnWMSoBgJttgcAWPLUJBgC41xOFlxBzy2mtnvtEe0P
         OuRZxStsvPk7Vg3KtVIkp3Jq1tPXFz+p06V1Avu+8k6Kbm+TwV/Ek13vSeQ1qoaruRxT
         UafK46ACkEOj9bIVB4/T39azWCIpcUNiHUBmBk3285soExJuQ1bVIa9DGXtuQjOXowsI
         kYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929472; x=1789534272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHMlaR7e60WLjZys1KqBq2H9AqQjLlKM6AeYANxxwuc=;
        b=P/Dud8w5GdBCt2UeBFFqX5gPIwRYc20CZ6lKn5fJV0LWMi6KZvlZ4noEKfScAPWJ2+
         jUUgWkZ9JJGicmL6OitsW+47xuUsdtIIj5qBLTyDIAHMQzbtB4sIp8mqHaaJvaR99x2W
         XQ+kpKGhGjeAF0s7l18Q2XRxIrSpRou8Jx4JKN6CnPukNp4uI6NZKAHc2kTm5Kb6KHYL
         UsD468BTu9A6oiWgP+8SK2Melt3aLrXVKqgkQ5Fw3LXvlPB+Tpy7WBt5IQiPyzISrXxH
         saCrf4TLxqKDAvwfXTEhcdikK+ViL0zJJqNwwlfPtoaa/6ljQFmA8YAxFA1I9bFCZbFm
         twwA==
X-Forwarded-Encrypted: i=1; AKwUvBwBAq3TB/lgcEpDJc2YA/HOmGFD/yjYJX9cqUzN1NOLjQQnqmkYKTAtYRK4ZssE6B7cqyR3w2E=@vger.kernel.org
X-Gm-Message-State: AFuF++kfavqY+MNV7+hRM09iLGmWFL7o9EK95bc6KR6GfXvEtiCilRBp
	jKAHIf0jQx1+zydYgFs1kbaB6EB7HXtV4V5JE1SViyp2XZAVTkcO3/ODe1EHU5hv3UcwJY+JHdj
	KCfu80Nao+rR+F/o9jK1gAVPsPzMF+wg=
X-Gm-Gg: AYBFou2CIHgALh7OLvCutzuHwH4wIcdEVpwtDwGsZjAQNo0bR/AlZ4wLJXvO8ZTV5OR
	FfVwISY2WPF0TV+xARDXup8j/lYG1x/sk3OC/3BYA8w4Jmt0yQpZUigA2j9edSdjaPXKTJ8dhq/
	hD1585c3Cfm+Wx3FXBV6jFlZTuWHgmDa8dgYEF9O2NFkL8a7WckLDvNAoYbg1V32pykhmuAgfOX
	jKFW9T5RyRKdZJlWheQU0dZ/MMvwrlgM56IBEOvGqPH66vIU8gFiPNnG8KrDvkRmD2Ut1TEKmdj
	2yeSerCaUictcAkMe8vw+1f1g03ol1gwECV6IZP2U6qzjUZiJ7sWjv0ECMhWdfanwxueT5R9/vi
	udRhtsSkt+1kMPqjv0gSRmCdQ8i9c1ODLT+3C2WheQOe0Bw1RojFDzcrLLn2D1hm7aWA=
X-Received: by 2002:a05:6a21:9102:b0:3c4:396d:4a6c with SMTP id
 adf61e73a8af0-3da39d18692mr53393702637.5.1788929472160; Tue, 08 Sep 2026
 21:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903073252.339250-3-phucduc.bui@gmail.com>
 <178880965410.219967.16945994924537630103@kernel.org> <CAABR9nHd-S-3MgTAZk=JMCDEkHjuHqwsE_9h+14tXdhvWdn_SQ@mail.gmail.com>
 <20260908084919.GM40544@horms.kernel.org>
In-Reply-To: <20260908084919.GM40544@horms.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 9 Sep 2026 11:51:00 +0700
X-Gm-Features: AcwNN1XRE5IMlU-W-GlbxFhG9fEet9UOoPLMR7lj76kvZQxj4Z6jKvrR_rWkHeE
Message-ID: <CAABR9nGvQQkjRhpefze24LARK0ZNhYOr2NM=_j_ERifwmmycpw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net: xilinx: axienet: Handle optional IRQ
 return value correctly
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, radhey.shyam.pandey@amd.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com, 
	andre.przywara@arm.com, hancock@sedsystems.ca, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > OK, agreed, I'll drop the Fixes tag in this case, since this is a
> > no-op cleanup rather than an actual behavior fix.
>
> Thanks, with that addressed this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Thanks for the review, Simon.
I=E2=80=99ll send the updated version shortly.
