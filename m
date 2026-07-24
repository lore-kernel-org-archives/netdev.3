Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748741D624
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885661; cv=none; b=Rb8dqAW0eH+T/N2bqkMLISmEt0frLjhVhPqkCNzoHaVzlyMFmZHWSFwzF0WjLzsOtu4v+YvuLmJ5WF7rP5A5/NRxVIuJg4sOFWLmgTJFoyMUlFpYa9xru07SyQsvBwERuKYw55ZNj/TvsIxNUZFOdaf7oBtwFDrZsFz4Erl0el8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885661; c=relaxed/simple;
	bh=eEHYVO+8SMp72Aikf1BTPb+z+tN7m8Nqaiq2j1hpizo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edWrpltg7xMjBzFmSTl/5M3p1TbapqOlkJxGT5fYvHW7sOL6foRcDl74pX9r/F1DnRcMyRSqsfWmV26Zl3f2+6OgDdJE7zh0p0uE5HsYwyRUE+6JlpPkcN7sNWo52HngttIARCEc0sqy9VOiTIpXo+Pl37HPlT8HuM1IqY9W1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+6JRBKx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+6JRBKx"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-476a130c138so285798f8f.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784885655; x=1785490455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0PTAnwhwEwXcpdKDmAEPJHxsWs8qeXebzHRT3KbsMYg=;
        b=D+6JRBKxCsEoSSvp8OXgOzyGpSALU1msmVoKaBfZyORIU0xM9qTcm6HeNFSbpkDs6k
         kr+UDZhf3NUQC1l4pf6RWWh59y5tG5JaJ4zmdOggzErcZ/vVHtqx102Cfif3IyPjgznb
         hzIhspF5MEuT5aZ9bkYKW91MmjlJORk7iislGf5ww50GXpvmVnue5AT88E1MiAT/Gr6b
         Cuk8ri0uGZI3nbppZxvljdvbqY2aLAZh5S/Djsexh0aq3a2F5Odr6PQPPqKThdJ4j9BZ
         UWDh603sQLihLeDrEAEgt5i6WFmcUZeeAabfuog3NiiZaELBjnrEDpiqUN0zNF+6PmU8
         Gmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784885655; x=1785490455;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PTAnwhwEwXcpdKDmAEPJHxsWs8qeXebzHRT3KbsMYg=;
        b=RBHzmQsttKou5KHtRxeAoUmbmK/TNA04tv7uMn6leaYRdb1pEW6OLRbN6oEsyz9JFZ
         U2uha4p6Np3cyK/4L0E034joLG5cXfBJClYfPxAimW50VS+aUF0/taPSjYj/SxjZLpWp
         cQ7KKPc3gohDg1FwUhLE+fGL1jaKo6EiZTWW5FEfwNlIOam9vv53Li0ysTmR01HEnR+U
         1hal2rT6JpWSLFzNzOWr2Nk+8g/UT822aPd5R79bFs28YGKnKPNUdNwgykY37udqtK1j
         zFFFK4qCCqlUeQAqlKdBG1L8/GyW73s7sYelvJXI8oET5lYIViMGqaVk2NypN8HI9Icd
         MOZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhbmNOwf+P/qRyoCsJ/KPpvevQNNeHOi4JG8kDChVQHbSmCE7Ke0aHy6hcBGpkkJsF6aFsdOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuh9YogFpCgbMchNSVPuAdntlg0Hz5BfaAkIY8jpkF1VNbQ6g5
	SMugtGpG2sVoucwL0QNdVrVHuDHEz2SrAKLjXtLO0rR+S73GmLrM7AWdtw7HmRHZKVQ=
X-Gm-Gg: AR+sD12GcgXpFM5pF3u8UznWTHeif/YB4E/9kF3hDWhSKiiY/2wMM2UBsZRVjJbW+pA
	0WZYzSQ7bln5aAHTjzczeZZXUWgW6DpgXvvbp+FE+gWLOFaXU+yw3Fy9ejcyLxdC55TWRBr7QSc
	0D1APLDJyWETzwXe/Ms0NvdZrubFSry25RcM64GgVvcmK6c2ko+etVZpMcMJwgC37XxCBnOhFI8
	FI8oSAG1hiwuDYylKK+nMqQaWf2/MXFE2EQQG1O00VwKJxmIwMdVzY9g6SRlSfbgNoUNgrXOIXN
	TUJK4l9DtJreRyAK4CQGuKyeSqHKfWcdhihPolQ9KT6l3W7RTaeH5s3RRYzU0soRrLgZMj+jay9
	kV1s3ynw2LXxlNApXjUcOGdfFOVNL7S2NhZiEgM3mqkO9GLB+jVlGghUXhwBpUTT5IbOpjloFnd
	n2Kdtk5SwlRL4nOA==
X-Received: by 2002:a05:6000:2906:b0:479:e2ea:3d51 with SMTP id ffacd0b85a97d-47f8da6c47amr7551647f8f.17.1784885655415;
        Fri, 24 Jul 2026 02:34:15 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:d8e1:da6c:62ef:6ff9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm21110105f8f.29.2026.07.24.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:34:14 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:34:10 +0200
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
	chris.lew@oss.qualcomm.com,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a
 single coherent block
Message-ID: <amMxkrW3mu48HIOr@linaro.org>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
 <alXm0rp3NK62G3-3@linaro.org>
 <c8417ff3-db92-446a-acf8-8c73c83b85de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8417ff3-db92-446a-acf8-8c73c83b85de@oss.qualcomm.com>

On Fri, Jul 24, 2026 at 10:16:31AM +0530, Vishnu Santhosh wrote:
> 
> On 14-07-2026 01:05 pm, Stephan Gerhold wrote:
> > On Tue, Jul 14, 2026 at 11:02:32AM +0530, Vishnu Santhosh wrote:
> > > On Qualcomm SoCs where the modem (e.g. the mDSP on Shikra, VMID 43 /
> > > NAV) is the AXI master for BAM-DMUX RX transfers and the XPU enforces
> > > per-region access control, each individually DMA-mapped RX buffer
> > > requires its own XPU resource group (RG). With ~16 RGs available, the
> > > 32 per-buffer dma_map_single() calls exhaust the table and the first
> > > inbound transfer faults with an XPU violation.
> > > 
> > > BAM-DMUX is a singleton (exactly one instance per SoC), so the
> > > destination VMID does not need to be a DT property; it is looked up
> > > from the compatible string's match data instead. Add struct
> > > bam_dmux_data with a single vmid field, and a shikra_data instance
> > > hardcoding QCOM_SCM_VMID_NAV for qcom,shikra-bam-dmux.
> > > 
> > > When match data is present, allocate all BAM_DMUX_NUM_SKB RX buffers as
> > > a single contiguous dma_alloc_coherent() block and SCM-assign that
> > > block to HLOS plus the VMID once at probe. This reduces RG consumption
> > > from 32 to 1. The block is never reclaimed across a modem power cycle
> > > (bam_dmux_power_off() does not touch it), so the probe-time assignment
> > > covers every subsequent restart without re-assigning or reclaiming. It
> > > is reclaimed to HLOS only once, at remove or on a probe error, and if
> > > that reclaim fails it is leaked rather than returned to the page
> > > allocator.
> > > 
> > > Each rx_skbs[] slot is pre-assigned its virtual and DMA address from
> > > the block, so no per-buffer mapping is needed at power-on. Because the
> > > coherent block is not page-backed, received payload is copied into a
> > > regular netdev skb before handoff to the network stack; this is an
> > > unavoidable extra copy on the XPU-enforced RX path.
> > > 
> > > Platforms without match data are unaffected: rx_virt stays NULL, no
> > > coherent memory is allocated, and the per-buffer dma_map_single() path
> > > is unchanged.
> > > 
> > > Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> > > Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> > So how do you handle TX buffers? Right now, they are just passed on from
> > the net subsystem. There can be up to 32 TX buffers in progress as well.
> > 
> > Overall, I have mixed feelings about this patch. It looks reasonably
> > simple, but fundamentally I don't understand why we need to go back to
> > the old days of implementing protection using a highly limited MPU (in
> > your case: the xPU).
> > 
> > Why does the setup of BAM-DMUX differ e.g. from the setup for the crypto
> > engine? Crypto is also using bam-dma, but it avoids this inflexibility
> > by making use of the &apps_smmu. Is BAM-DMUX not covered by the SMMU? Or
> > did you just decide to bypass the SMMU in this case? (If so: Why?)
> 
> I checked with secure systems team on this. Crypto BAM is
> behind apps_smmu, so protection is enforced through the SMMU's Stage-2
> page tables.
> 
> A2 BAM (used by BAM-DMUX) is present in secure domain and does not
> support Stage-2 translation on this SoC, and there is no IOMMU domain
> that can be attached to it. The only protection mechanism available is
> the xPU.
> 

Thanks for investigating this!

So is this a hardware limitation or something you could change with a
firmware update? Could you move the A2 BAM out of the secure domain and
protect it via the IOMMU instead of the xPU mechanism? The other modern
platforms with IPA do not have this limitation, they can use the IOMMU
for this.

We can try to support the xPU protection mechanism in the BAM-DMUX
driver, but it's pretty bad from a performance and memory usage point of
view if you need to copy buffers around multiple times. So if you have
some way to change this in the firmware (and there is still time to do
so before production boards ship), I would strongly recommend to
investigate that.

Thanks,
Stephan
