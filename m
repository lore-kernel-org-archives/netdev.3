Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86983403ED;
	Tue, 11 Aug 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434790; cv=none; b=j3jG4kPoNzM/IRcgRpjzpFZeOiJ3Ll1L9WzxkjImZjZ3sZQCmvbjLH2/x4VOLjQ0BzkjZM9U38J4BqFu1AMXF71KfoMq/b1oCCs862XSVEq92C/AO/6PUzPq0kpHOIrV/Rw/lEKNnBlaLMpG+oihtovr8R08cs2Sr4hBIB+P/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434790; c=relaxed/simple;
	bh=6UhfDLt02W+w1aSf5PwyzTuLgfXlAuEK3jciPocEXbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFFXgycVEB7fr64cxPFxwNug8Mhgx3qhb1uH/XtRIroK1NKxOB0EZHaNKwJY0gkVsmiUuaOa5feuTkmLPpL/ltVRudKP2FslXCTcWUAOhq45kK9Mn8zmR8oqckxi0aIGvXj2++qZvmO78WFFSD/XOpqYxiIxGeLpBC7PgPFYKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+Z/P+1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+Z/P+1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E061F000E9;
	Tue, 11 Aug 2026 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434788;
	bh=8S+yPkqlGljd464X8KgFc9m70P1r8YKi+gX4Vwc11pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N+Z/P+1yaiowxaFgLulkwg8mn6JB5Mi33afAUO81GBDwVkoDKA9FTrG6wa1SzJkDU
	 ftFk0gRu60W8fSfKTHa0kS7yvT3pyeR+NZug5eKc7kujWdt75BY6XQDP7UWr5uQW52
	 lG0ApD6vs/5Ag8lvGs/Co4bu177dKjRUQeT6r5zjtmXxaPjq3R9Qww8MHIDigJwHKl
	 /mBBkg3TOVAlJEn4CHWfKKCxhcVkkPg9Q4r4aE8Df7n1u/Cfg5pE9cZg1zuezgKoe0
	 XuX7Vmq6+k2zIg0i+ls/gBzb89K1okUjvEVd+JcKT6XOYxNYqOLspktiGOlxrNsSwI
	 1Qmq1UXgDWguA==
Date: Tue, 11 Aug 2026 09:53:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: David Heidelberg <david@ixit.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH v4 5/6] nfc: s3fwrn5: support the S3NRN4V variant
Message-ID: <20260811-beautiful-mink-of-advertising-3cde65@quoll>
References: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
 <20260807021001.239389-6-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807021001.239389-6-jorijnvdgraaf@catcrafts.net>

On Fri, Aug 07, 2026 at 04:10:00AM +0200, Jorijn van der Graaf wrote:
> +/*
> + * S3NRN4V RF calibration data update: the HW and SW blobs merged into one
> + * stream (HW first), pushed as START_UPDATE, one SET_OPTION per 252-byte
> + * section, then STOP_UPDATE carrying a 16-bit checksum (running sum of the
> + * merged stream as 32-bit words).
> + */
> +int s3fwrn5_nci_rf_configure_dual(struct s3fwrn5_info *info,
> +				  const char *hw_name, const char *sw_name)
> +{
> +	struct nci_prop_dual_set_option_cmd set_option;
> +	struct device *dev = &info->ndev->nfc_dev->dev;
> +	const struct firmware *hw_fw, *sw_fw;
> +	size_t merged_size, i, len;
> +	u8 *merged = NULL;
> +	u8 stop_cmd[3];
> +	u32 checksum;
> +	u8 sub_oid;
> +	int ret;
> +
> +	ret = firmware_request_nowarn(&hw_fw, hw_name, dev);
> +	if (ret < 0)
> +		return ret;
> +	ret = firmware_request_nowarn(&sw_fw, sw_name, dev);
> +	if (ret < 0)
> +		goto out_hw;
> +
> +	merged_size = hw_fw->size + sw_fw->size;
> +
> +	/*
> +	 * The stream is checksummed as 32-bit words and pushed in at most 256
> +	 * sections (the section index is a single byte); reject blobs that
> +	 * would silently break either.
> +	 */
> +	if (!merged_size || merged_size % 4 ||
> +	    merged_size > 256 * NCI_PROP_DUAL_SECTION_SIZE) {
> +		dev_err(dev, "invalid calibration data size: %zu\n", merged_size);
> +		ret = -EINVAL;
> +		goto out;

Why does this error path kfrees the 'merged'? It's not yet allocated.

> +	}
> +
> +	/*
> +	 * Ask the chip for its current calibration versions and skip the
> +	 * upload when both already match the blobs; a mismatch or an
> +	 * unparseable answer means the upload proceeds. GET_VER answers with
> +	 * versions, not a status byte, so nci_prop_cmd()'s return carries no
> +	 * meaning here.
> +	 */
> +	sub_oid = NCI_PROP_DUAL_SUB_GET_VER;
> +	info->dual_rsp_len = 0;
> +	nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION, 1, &sub_oid);
> +	if (s3fwrn5_nci_dual_cal_current(info, hw_fw, sw_fw)) {
> +		dev_dbg(dev, "calibration data already current\n");
> +		ret = 0;
> +		goto out;

Same here

> +	}
> +
> +	merged = kvmalloc(merged_size, GFP_KERNEL);
> +	if (!merged) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	memcpy(merged, hw_fw->data, hw_fw->size);
> +	memcpy(merged + hw_fw->size, sw_fw->data, sw_fw->size);
> +
> +	checksum = 0;
> +	for (i = 0; i + 4 <= merged_size; i += 4)
> +		checksum += get_unaligned_le32(merged + i);
> +
> +	dev_info(dev, "calibration data update: %s + %s\n", hw_name, sw_name);

Drop

> +
> +	/* START_UPDATE */
> +	sub_oid = NCI_PROP_DUAL_SUB_START_UPDATE;
> +	ret = nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION, 1, &sub_oid);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to start calibration data update\n");
> +		goto out;
> +	}
> +
> +	/* SET_OPTION per section */
> +	set_option.sub_oid = NCI_PROP_DUAL_SUB_SET_OPTION;
> +	set_option.index = 0;
> +	for (i = 0; i < merged_size; i += NCI_PROP_DUAL_SECTION_SIZE) {
> +		len = min_t(size_t, merged_size - i, NCI_PROP_DUAL_SECTION_SIZE);
> +		memcpy(set_option.data, merged + i, len);
> +		ret = nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION,
> +				   len + 2, (__u8 *)&set_option);
> +		if (ret < 0) {
> +			dev_err(dev, "calibration data update error: %d\n",
> +				ret);
> +			/* Abort form: STOP_UPDATE with the sub-OID alone. */
> +			sub_oid = NCI_PROP_DUAL_SUB_STOP_UPDATE;
> +			nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION, 1,
> +				     &sub_oid);
> +			goto out;
> +		}
> +		set_option.index++;
> +	}
> +
> +	/* STOP_UPDATE with checksum */
> +	stop_cmd[0] = NCI_PROP_DUAL_SUB_STOP_UPDATE;
> +	put_unaligned_le16(checksum, &stop_cmd[1]);
> +	ret = nci_prop_cmd(info->ndev, NCI_PROP_DUAL_OPTION, 3, stop_cmd);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to stop calibration data update\n");
> +		goto out;
> +	}
> +
> +	dev_info(dev, "calibration data update: success\n");

dev_dbg, drivers should be silent on success, unless this is somehow
important and unusual message.

> +out:
> +	kvfree(merged);
> +	release_firmware(sw_fw);
> +out_hw:
> +	release_firmware(hw_fw);
> +	return ret;

Best regards,
Krzysztof

