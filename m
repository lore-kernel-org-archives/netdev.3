Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB83AE1A5
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669667; cv=none; b=ANu/YB9qpgLogSUdPyve1XW6NAueZiXMnLrI43ySc6hEDJh98YsyDTVk8JfH0YfZ7S2lXbxE7E/5ISH8YREayeSfOcfc8Djew78vquDEwQCxX82wOpludyW2XgW8RXNM6LNVt/+5eLUma9V9mfzYinsY5bX0Wrk4J5mgXe8sWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669667; c=relaxed/simple;
	bh=LIHyxk0R1xJ4ROSOFxfRJzSZQA4fpHxRcU5DJ/EALMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPVOHLM+XMGR9E1sbWu+n+gnT1Sjkq0OAdC+3FlF6a0rQGdsELzKZ2qZ0GPg45Oc7iFRcTt5PM8n1M/KYuxHhtSwnApDJedfdWpmD4ysZrNarTIFp4R5W3VNOYD0yw4l6g9kdRZr/UMizEOqAv3Rlx90CGh1JYehk11Znz134nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coZTWqTT; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coZTWqTT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso3524805e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790669662; x=1791274462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tfRVF/0pUKYKb8L3URhvanQPa9F0a2plxZV30Tx9qjY=;
        b=coZTWqTTXp/Okj5ajZA+JHks5sAoGvfOaEavS2BGQ+jkw/zXToijK6RRkLpL6kxRiC
         5RT2uRlNwAy8AhPJRsYGxosIX1DLK55/5nQnxLeAkOusxwFOlqwmJwfir45iUTECDyL+
         u+savtsmJOizFvUvyVcimEY3rWWbMlQ7wQEVGGywrmpam9laifOVPqV+8SY+1jXKmjXa
         5D4kI1qu/YisS82KygGAgDc3RDar8SdwjXOuYpx7qYC9d8syKMc7HDSHUad+CZRoHJu1
         G2MukaVqAS2hE5ZJu+0abyHwpicRcP4+fu68mduh53zgN6PR+AKgHL+R5iHkXX8X4Ybk
         BQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790669662; x=1791274462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tfRVF/0pUKYKb8L3URhvanQPa9F0a2plxZV30Tx9qjY=;
        b=YtYtdqO30w2g8PMBp/Yk3bqANVRLXlG0eiVeMkpMVe1L5w5yZpPkD/xZ/RIGCrH2Py
         revKDFTQ4+gvehxUjPLx2Wy7oQ6LXbhEHYSAwZ+x9xsQRnsH8ZZ5FXsIhvgkgC7GnTC4
         hkVK5gnyNZ2kF4DNtCS9Am0GiAGWx5jI45zz2sbicD0HtQ+xrN5v+pEPPfIz3Qc3+Qll
         QEZZ0SmnG3DT3jgEDMNwJyZGiCmwaIS5XwIfXXBjOMyULuSz0QhTUHTPAPVTFcVu0w+x
         mfbUi9lOMaC47Yy/3pNRAXXSmjbdJgmpwRsnsC1iN6ll616KdZ9q5LG5oVF+2GkS0I7s
         MWow==
X-Forwarded-Encrypted: i=1; AKwUvBweGGPcW4Cvna/8Dymdgod8bZxRwBDW2FElykvapof+VVF2yIrdOgO96T0hapAuVZ56+MThxSk=@vger.kernel.org
X-Gm-Message-State: AFuF++nPPGseewJpDRjfHdPWKKQcPuVeHzv050yNfRdl47QapxKLNFT3
	UTfDXZtvNA68762tHtuGm6aIvpoCQQyzW5+ctrqvt9JnXQnVGGquZUHaOzBthXqAYPU=
X-Gm-Gg: AYBFou3NTE1Vvl57au7Tsp5pE+xvFZDUDUPsFvLBofFmZji8J/7bSWnu7JXBDgAu32q
	tMU0gL3LfEMU/tL1ixxBsnOu9OGP130VFxenjwE0wHOAqWSS0gpErp4/OfqrmBThTOZfJ3iYLES
	nvgtYIUMHX7hGHAvwkML/IGVvm1aG2+fc50jN4NNOP8VZnjGJEoJwCebnd5TGBM23I/iBYDLfWs
	caWc0MqOM8rmD3u+msuiiwOprxaJFQgpugLgrKqMcr/mzcIfmjRW0dXEKLrM6YJ8Q01RZRSWQ4n
	HOSfDCYkka6xY5M4jFrA0j4lsvtVGHXwEvguAstE2hKH5ArNbLMlvrOJ0/XOKv8UKgWTH+QIgt+
	Hy5noxcF0AfPBkWrFRj2RsB4cuIzLiBtJmM5BUN+kOfw1cb8+ATP+T9xLnHMfkeALrJDHkzMwjd
	cyorzL4kMSiZzE90Jq8pYk7cE3b1i6oxlrMDrN49K+x+eqXIGdw6Uk5l+pEDhubRvPlFABx+MNM
	g7IVxBl9w==
X-Received: by 2002:a05:600c:8411:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49fe66ef334mr254737745e9.25.1790669662517;
        Tue, 29 Sep 2026 01:14:22 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff25:4f41:e613:f8b0:9fed:6cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0d538fsm62057605e9.1.2026.09.29.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:14:21 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:14:17 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH net-next v2 0/2] net: wwan: qcom_bam_dmux: Add restricted
 DMA pool support
Message-ID: <artzWeUgTHvGzo1m@linaro.org>
References: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
 <ca3c86b6-c837-4298-a1ab-4fc61a2f8a0a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3c86b6-c837-4298-a1ab-4fc61a2f8a0a@oss.qualcomm.com>

On Mon, Sep 28, 2026 at 04:02:47PM +0530, Vishnu Santhosh wrote:
> On 20-09-2026 08:32 am, Vishnu Santhosh wrote:
> > Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
> > domain with restricted access to system memory. BAM-DMUX DMA mappings
> > and BAM descriptor FIFOs must therefore be constrained to a designated
> > memory region that can be shared with the modem. Accesses outside that
> > region can trigger an XPU violation.
> > 
> > Add memory-region and qcom,vmid properties to the BAM-DMUX binding.
> > When qcom,vmid is present, the driver SCM-assigns the entire restricted
> > DMA pool to the local and remote execution environments before requesting
> > the DMA channels.
> > 
> > The restricted pool then contains the BAM-DMUX mappings. When the BAM DMA
> > controller references the same pool, its descriptor FIFOs are covered by
> > the assignment as well.
> > 
> > A related binding change allows the BAM DMA controller to use the same
> > restricted pool for descriptor FIFO allocations:
> > 
> > https://lore.kernel.org/all/20260920-qcom-bam-dma-vmid-ext-v2-1-4dbbff0e57c8@oss.qualcomm.com/
> > ("dt-bindings: dma: qcom,bam-dma: Allow memory-region property")
> > 
> > Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Replace the Shikra-specific compatible and coherent RX allocation with
> >    memory-region and qcom,vmid properties.
> > - Use a restricted DMA pool for BAM-DMUX mappings and BAM descriptor FIFOs.
> > - SCM-assign the complete pool before requesting the DMA channels.
> > - Validate the remote VMID and restricted DMA pool configuration.
> > - Link to v1: https://lore.kernel.org/r/20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com
> > 
> > ---
> > Vishnu Santhosh (2):
> >        dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid properties
> >        net: wwan: qcom_bam_dmux: Assign restricted DMA pool to remote processor
> > 
> >   .../devicetree/bindings/net/qcom,bam-dmux.yaml     | 38 +++++++++
> >   drivers/net/wwan/Kconfig                           |  1 +
> >   drivers/net/wwan/qcom_bam_dmux.c                   | 95 ++++++++++++++++++++++
> >   3 files changed, 134 insertions(+)
> > ---
> > base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
> > change-id: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1
> > 
> > Best regards,
> 
> Hi Stephan,
> 
> I followed your suggestion and updated v2 to use the restricted DMA pool.
> 
> Please let me know if this approach and the implementation look reasonable and
> meets your expectations.
> 

Thanks, the approach looks good to me. You received some comments from
others and Sashiko already, so I will make a more thorough review from
my side once you have addressed (or at least considered) them for v3.

Thanks,
Stephan
