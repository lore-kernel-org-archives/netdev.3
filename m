Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789B345CBE
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781338638; cv=none; b=qa89O86660aJZ0sd/jQt/l3anueMj1WQhEXVivFrE4SCqxt1H0CrsvRY+YiSrLx7pqTkuD4J8Y4uWyfOZUNlo0i3LsTiNbBfZ/XmJmT0cNzJnC2Xm4ZlTdOXeH3iJOwylItgUa59aaqerVWhiG+ANjhD4uPYv0fsskexEKuyfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781338638; c=relaxed/simple;
	bh=G4vZBc8ZLUPUE5upL5hARAo5Vznl/2YxfVZfkWN3zUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DviWSlKMTmnEUtNrNmKR1i+9cPMibePDR3komOMXzchCDIytbFBrgEtfLI5uwVZRcYG1iQUYlpcn23oHHwzARAbzWKxjofY/5ukqfZazm6Zp8xIeNXPg5VGGS74kbhl709Tl751yWGManjJJllzYtluiBcxnO9Y5lQd3IzOaHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGOCDLCF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pDqkIWkg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGOCDLCF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pDqkIWkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781338636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS0zNMZBIRupuxM8vXWdAOrpg+vXBR7TRgikpV9JDpU=;
	b=DGOCDLCFQpU7fx7ZeuSH/6Cy5esZfBfQw+GIy+fRY2dOWxJnaxPH5z0QPtqDfy7ItFnMTL
	RWEpBlB53JomGAIrEQ71xmoTzxPfXbluzNcRXrmSHb1GXbM7qCQ4eBmh5t309WdYMsEG9O
	MhbiM6D4FcyzNhtfgE5wXPajuXJEORo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-sm5w1txQMLC8K9PrWSyOcQ-1; Sat, 13 Jun 2026 04:17:14 -0400
X-MC-Unique: sm5w1txQMLC8K9PrWSyOcQ-1
X-Mimecast-MFC-AGG-ID: sm5w1txQMLC8K9PrWSyOcQ_1781338633
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ccd3213beaso35588296d6.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781338633; x=1781943433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YS0zNMZBIRupuxM8vXWdAOrpg+vXBR7TRgikpV9JDpU=;
        b=pDqkIWkg1NbqVcicFBMP/cJfkI2Qx/a3zqVY4rtz6wpoZnBI8PuM27B9vYBI4fuVEU
         LFNHQ19RUZsBywSSFM1OHjHQYd47YB8TOwISpt4OH66YGa2dVJQp8si1Pvvty03ARgJM
         JMciWvPTGawbOnLUGQUHXAfDrtdTC36kORDyCNivMpBUkt21gMqGCldPkPBrO4HemKmX
         qMprhvrBDkxzSb/3gpu8NS356phlEogt+V56Pmj3wqGvafZr0WSY82K/SXG/6Zoj470N
         WvmX36CrIDyjDEYcQZFSqMLl6pKKLfnk3IrhISAG72jMFaUG53cm3JpIMpVQxqISY+z9
         sqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781338633; x=1781943433;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS0zNMZBIRupuxM8vXWdAOrpg+vXBR7TRgikpV9JDpU=;
        b=KJ2NQw5FsLMiM/LF6fG4RJ3Xq22nMdKn4RtdaqsRoAwOCQHQoge8/DcQH7meaYWnbF
         laGE2Sx506sYjhOFy5ZOfDo3eeSGtsiJN8H+cPI4iILQa3uT3GgJjRvoUJO1nwilIVD5
         AfFKeTgFJwxS2RQLBfBj7A64mmG+Molojzm0IRFbkn+bYasXSZKf2g47g4HG7m8zRqTa
         +wxCtCBm6/rPb53P8uqjYSRlgoIE+lwPVnegiLarQb8dXx3fj509sphagH0ivasOvzMG
         A+LpwZmS3T4Fh6Xlzs4x0y8cPfVNZks4b0Q1ElgT1RMxWr1h5Y+h/SdPo0PdrwP0ypzo
         caFA==
X-Forwarded-Encrypted: i=1; AFNElJ/a5MXIKlO/Jksz7ENVpGOePYkjLcgAmTHQkfLJJlqzDVU72up6N/HJS/1EXaOne7bw+5Jcl08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdTCjDIXzE+viSLUVx+g62EtTk6UaecDGJIybN7RBiCn3ZkdZ
	nMLscgf9UX14VnkfgsBA4q7C3t2F3y8jLOFyW3J9M+5EfYxCljz4gDuNEw3e2jwyFen2qeYAU2F
	7cxeqhpmrmNFFN0jMYKrll/BFQXpfrWE7dPbDQU1GIo6Fv4wPNvOT+yhRGw==
X-Gm-Gg: Acq92OFmTeYsOyyz/3sdHiSOI79px4aCW4JZOEwCvb8UvGInxUXSji9Lj2fM3yCjURi
	96a9fVjATUIrvQqtWi3srLQeBHQwG4ze6hwh60hnL6qxSJ0rc7KcjBG+ddCUc/6rgJ+St62CYlK
	u8B+u26U9AXeDjmQ45mSrnM7YCeZefz1VX9dkalHpB7NsAMNMmmmtLEQ4cANVvMOjWYoT9KJfjE
	hgEsdSRNiscwmUiyo0CsGM2lJ9kgepNDiooHNe1twPYpcZ/3rWsX7ygDIcWsaNV5hJ8/h/ujDIg
	zSl/8wndMXYuQIGXbI+w/7UsmF2bHpWe3aTEOcBONztgXKzRtIEyrFIcPV2S5Fmlw14GlcDe8Lk
	HfuBy7vf1dXZ+NW9OgyRXopI3DP+WZ2ibXLCQvSwXYP7Ylm3LHqv3B2E=
X-Received: by 2002:a05:6214:2249:b0:8b9:3907:166a with SMTP id 6a1803df08f44-8d32c8ce11cmr102409616d6.17.1781338633473;
        Sat, 13 Jun 2026 01:17:13 -0700 (PDT)
X-Received: by 2002:a05:6214:2249:b0:8b9:3907:166a with SMTP id 6a1803df08f44-8d32c8ce11cmr102409346d6.17.1781338632991;
        Sat, 13 Jun 2026 01:17:12 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b2d004sm47099976d6.15.2026.06.13.01.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 01:17:12 -0700 (PDT)
Message-ID: <9166857f-880d-4324-9300-9cb1da600aed@redhat.com>
Date: Sat, 13 Jun 2026 10:17:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] pds_core: add host backed memory support for
 firmware
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, Eric Joyner <eric.joyner@amd.com>,
 Vamsi Atluri <Vamsi.Atluri@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
 <20260608223256.12357-6-nikhil.rao@amd.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608223256.12357-6-nikhil.rao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 12:32 AM, Nikhil P. Rao wrote:
> +static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
> +{
> +	struct pdsc_host_mem *hm = &pdsc->host_mem_reqs[index];
> +	union pds_core_dev_comp comp = {};
> +	union pds_core_dev_cmd cmd = {};
> +	int err;
> +
> +	memset(hm, 0, sizeof(*hm));

Minor nit: the buffer is kzmalloced() no need to zero it again.

> +	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
> +	cmd.host_mem.oper = PDS_CORE_HOST_MEM_QUERY;
> +	cmd.host_mem.index = cpu_to_le16(index);
> +	dev_dbg(pdsc->dev, "Sending devcmd for mem query index %d\n", index);
> +	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
> +	if (err || comp.status != PDS_RC_SUCCESS) {
> +		dev_err(pdsc->dev, "mem query failed err %d status %d\n",
> +			err, comp.status);
> +		return err ? err : -EIO;
> +	}
> +	hm->size = le32_to_cpu(comp.host_mem.size);
> +	hm->tag = le16_to_cpu(comp.host_mem.tag);
> +	dev_dbg(pdsc->dev, "mem query returned size %d tag %d\n",
> +		hm->size, hm->tag);
> +
> +	if (!hm->size || hm->size > PDSC_HOST_MEM_MAX_CONTIG) {
> +		dev_err(pdsc->dev, "invalid size %d for tag %d\n",
> +			hm->size, hm->tag);
> +		err = -EINVAL;
> +		goto err_del;
> +	}
> +
> +	hm->order = get_order(hm->size);
> +	hm->pg = alloc_pages(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN, hm->order);
> +	if (!hm->pg) {
> +		dev_err(pdsc->dev, "alloc order %d failed for tag %d\n",
> +			hm->order, hm->tag);

Minor nit: as this is a gracefully handled failure, possibly dev_warn()
is more suited and the message itself should be less alarming.

[...]
> +void pdsc_host_mem_add(struct pdsc *pdsc)
> +{
> +	union pds_core_dev_comp comp = {};
> +	union pds_core_dev_cmd cmd = {};
> +	u16 count;
> +	int err;
> +	int i;
> +
> +	if (!(pdsc->dev_ident.capabilities &
> +	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
> +		return;
> +
> +	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
> +	cmd.host_mem.oper = PDS_CORE_HOST_MEM_GET_COUNT;
> +	cmd.host_mem.index = cpu_to_le16(PDSC_HOST_MEM_MAX_COUNT);
> +	cmd.host_mem.max_contig = cpu_to_le32(PDSC_HOST_MEM_MAX_CONTIG);
> +	dev_dbg(pdsc->dev, "Sending devcmd for mem get count max_contig %u\n",
> +		PDSC_HOST_MEM_MAX_CONTIG);
> +	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
> +	if (err || comp.status != PDS_RC_SUCCESS) {
> +		dev_err(pdsc->dev, "mem get count failed err %d status %d\n",
> +			err, comp.status);
> +		return;
> +	}
> +
> +	count = min(le16_to_cpu(comp.host_mem.count),
> +		    PDSC_HOST_MEM_MAX_COUNT);
> +	dev_dbg(pdsc->dev, "mem get count returned count %d\n", count);
> +	if (count == 0)
> +		return;
> +
> +	pdsc->host_mem_reqs = kzalloc_objs(*pdsc->host_mem_reqs, count,
> +					   GFP_KERNEL);
> +	if (!pdsc->host_mem_reqs) {
> +		dev_err(pdsc->dev, "failed to alloc host_mem_reqs array\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		err = pdsc_host_mem_add_one(pdsc, i);
> +		if (err)
> +			break;

When pdsc_host_mem_add_one() returns an error, pdsc->host_mem_reqs[i].pg
will be zero. Errors are not propagate to the caller...

> +	}
> +}
> +
> +void pdsc_host_mem_free(struct pdsc *pdsc)
> +{
> +	int i;
> +
> +	if (!pdsc->host_mem_reqs)
> +		return;

... and this function will be unconditionally called on shutdown with
non zero host_mem_reqs.

> +
> +	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
> +		dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
> +			       pdsc->host_mem_reqs[i].size,
> +			       DMA_BIDIRECTIONAL);
> +		__free_pages(pdsc->host_mem_reqs[i].pg,

so  pdsc->host_mem_reqs[i].pg can be zero here. AFAICS at least
__free_pages() -> ___free_pages -> put_page_testzero ->
page_ref_count(0) will oops.

I find strange AI did not catch the above, so I'm possibly missing
something?!?

/P

