Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572394;
	b=t3dnSkxE97aabhrFNXWkbroUXKO+MF8m0X6Sb2XvSHFH3UZeoAMyMZgQnlEUoBqE4niv
	 SA9DLRgJun6aW5fPqgP4/m9z+lADtoef+WNwan0k+gcIAEBFQ0/LD70y3mXa871oy2ICk
	 9UTiTUPxcbInWTC0o/fWSJMDSvbs0a8vcWl4Rf5RudI0HxFX5ryS3KXFUJ2LkeNKZoLP5
	 SR9lPWbb6TNj7yA8Hfe7/+3bicITQnIcl6uMDWs/yVERHTZ1nJn+kUGqsJe7omvkmcnes
	 WitZ6dd6f2twguI3P3yQWdoTBkLEdw2vkvzxs+tAd73fdk+MkrydDtpZLDtOXrPZgcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572394;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vjBdevYdyu8B2nJWZEvNznoUFH7jzJidc2NIxAriwms=;
	b=wArAt6pkaY9NgPjp8d51bKDLzBNUQgUbsdok5NC5m1THFwZsnONc09nyuMNU0kkrFdpE
	 ajtPp55+VXkDSEwadrcgWxLOEUl7ekvmMcbvzgTFnDhoHW8d++S4xOAjTDqL7shhOxJgs
	 h2pgoMJ0D12K7Cr3qZ4kpbBXcaeiP7cTtoiiuqcYn57gZmW/4qZ+EsY/VLWv3EvqzV6xE
	 8+CyVzfnhnUU1ZysmLvEv5BJVqE68HrujaYZIZn3drP/69qUO26di8YH8UAR1b2D1hBt8
	 l9SzSa1m8N4iB1zvnPBovnQEm1JuBuYFfE8Ke+gGFpioGSW4rjNLwd3zjHZIuE0JAwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRHy4rDm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E47606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRHy4rDm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D161F1F000C1;
	Sun,  1 Nov 2026 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572394;
	bh=vjBdevYdyu8B2nJWZEvNznoUFH7jzJidc2NIxAriwms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XRHy4rDm9UU11FmbhWWhQ4Xz0O/wsqmIR7FSw/HJRg+ArxMvfx5TYXI5qDlCoBb3t
	 jVK05P8hRLu0/0ALYeCXJzTMYUzHj0918Qpr9lK/shqjZHLWYMN3zRUyr5D0Fyo99A
	 exyAk9BHWEinetTKylPIndujecguhJf0X6CQE/r2d7TP9pNc7tdM+AtHvqm3DTIv6u
	 ajKBXdLQ6a/fdsvxQU4hLVbelyvZaN6f64qCdHFOYopqQxp37f/guFBxcF/UAzN4vc
	 HVVM2VoUbxqxHcSBfzddLYLarQzPgDMGVp6qquzMk3DD16n1cBvyXL2eiff1TqSJ0/
	 SS5SRR2PxCJug==
Subject: Re: [net PATCH 01/13] fbnic: Reject a short MAC address attribute
 from firmware
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:13 +0000
Message-ID: <179357239326.3131.781900521655399006@kernel.org>
In-Reply-To:
 <179322336327.40667.6639719339988113582.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322336327.40667.6639719339988113582.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch changes fbnic_tlv_attr_addr_copy() to return int:
  -EINVAL when the attribute is not exactly ETH_ALEN long, and in that…

Pre-existing issues:
- [High] fbnic_fw_parse_qsfp_read_resp() in
  drivers/net/ethernet/meta/fbnic/fbnic_fw.c has the same short-BINARY-…
- [Medium] (Baseline decision: not reported.

--

fbnic: Reject a short MAC address attribute from firmware

This patch makes fbnic_tlv_attr_addr_copy() reject a MAC address attribute
that is not exactly ETH_ALEN long and return -EINVAL. It also changes
fbnic_fw_parse_bmc_addrs() to stage the parsed addresses in a local array.
They are copied out only once all of them have parsed.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 49b8813a35643..bcbeb0814b827 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c

[ ... ]

> @@ -609,13 +610,16 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
>  	if (err)
>  		return err;
>  
> -	/* Copy results into MAC addr array */
> -	for (i = 0; i < len && mac_results[i]; i++)
> -		fbnic_tlv_attr_addr_copy(bmc_mac_addr[i], mac_results[i]);
> +	/* Stage the addresses so a bad one leaves the old set untouched.
> +	 * Unused entries stay zeroed.
> +	 */
> +	for (i = 0; i < len && mac_results[i]; i++) {
> +		err = fbnic_tlv_attr_addr_copy(mac_addr[i], mac_results[i]);
> +		if (err)
> +			return err;
> +	}
>  
> -	/* Zero remaining unused addresses */
> -	while (i < len)
> -		eth_zero_addr(bmc_mac_addr[i++]);
> +	memcpy(bmc_mac_addr, mac_addr, len * ETH_ALEN);

[Severity: Medium]
This is a pre-existing issue, but is anything serializing this write
against the reader of fbd->fw_cap.bmc_mac_addr?

This memcpy() runs from the threaded FW mailbox IRQ path and takes no
lock. fbnic_bmc_rpc_init() walks the same array from the service task
while holding only netdev_lock, which the writer never takes.

The TCAM_REINIT bit handshake in fbnic_bmc_rpc_check() orders the flag
against the data. It does not provide mutual exclusion, though.

Suppose a second CAP_RESP is processed while fbnic_bmc_rpc_init() is
partway through its loop. Can the reader then see a mix of old and new
addresses and program a bogus MACDA TCAM entry?

The baseline had the same race, because it wrote the live array one entry
at a time.

This looks resolved later in the series by "fbnic: Keep the BMC MAC
address set whole across a capabilities update". That commit publishes the
array under write_seqcount_begin()/write_seqcount_end(), and
fbnic_bmc_rpc_init() takes a snapshot in a read_seqcount_retry() loop.

>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> index 3ef3935c0419f..e1ef134ddb944 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> @@ -724,12 +724,25 @@ struct fbnic_tlv_msg *fbnic_tlv_test_create(struct fbnic_dev *fbd)
>  	return NULL;
>  }
>  
> -void fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)

[ ... ]

> +int fbnic_tlv_attr_addr_copy(u8 *dest, struct fbnic_tlv_msg *src)
>  {
> -	u8 *mac_addr;
> +	if (le16_to_cpu(src->hdr.len) != sizeof(*src) + ETH_ALEN)
> +		return -EINVAL;

[Severity: Low]
Should the two callers in fbnic_tlv_parser_test_attr() also handle the
new return value? They still treat the function as void:

fbnic_tlv_parser_test_attr() {
    ...
	attr = results[FBNIC_TLV_TEST_MSG_MAC_ADDR];
	if (attr)
		fbnic_tlv_attr_addr_copy(str->test_mac, attr);
    ...
			for (i = 0; i < 4 && array_results[i]; i++)
				fbnic_tlv_attr_addr_copy(str->test_mac_array[i],
							 array_results[i]);
    ...
}

If a short MAC attribute comes back in the self-test response, the
destination keeps the zeros from the memset() in fbnic_tlv_parser_test().
The failure then shows up only as a generic memcmp() mismatch, not as
-EINVAL.

If the random expected MAC happens to be all zeros, the test would pass
even though the parse failed.

The prototype is not marked __must_check, so the build won't flag these
callers.

> +
> +	memcpy(dest, fbnic_tlv_attr_get_value_ptr(src), ETH_ALEN);

[Severity: High]
This isn't a bug introduced by this patch, but
fbnic_fw_parse_qsfp_read_resp() in fbnic_fw.c seems to have the same
over-read on a short BINARY attribute that this patch fixes for MAC
addresses. Could it get a similar check?

FBNIC_FW_QSFP_DATA is declared with FBNIC_TLV_ATTR_RAW_DATA. As a result,
fbnic_tlv_attr_validate() accepts any payload from 1 up to TLV_MAX_DATA
bytes. The handler only checks length against the host request:

fbnic_fw_parse_qsfp_read_resp() {
    ...
	if (length != cmpl_data->u.qsfp.length ||
	    offset != cmpl_data->u.qsfp.offset) {
    ...
	data = fbnic_tlv_attr_get_value_ptr(data_hdr);
	memcpy(cmpl_data->u.qsfp.data, data, length);
    ...
}

Say firmware reports a length of 128 but sends a truncated data
attribute. Can this read up to 127 bytes past the end of the attribute
and of the message?

The mailbox Rx pages come from __get_free_page(GFP_KERNEL) in
fbnic_mbx_alloc_rx_msgs() and are not zeroed. If the attribute is near
the end of the page, the read could also run into the next page.

fbnic_get_module_eeprom_by_page() then copies those bytes into the
ethtool buffer that goes back to userspace:

	memcpy(page_data->data, fw_cmpl->u.qsfp.data, page_data->length);

The coredump handler already has the equivalent check:

fbnic_fw_parse_coredump_resp() {
    ...
	if (length > le16_to_cpu(data_hdr->hdr.len) - sizeof(u32)) {
    ...
}

RAW_DATA is variable length, so a check in the validator wouldn't cover
this case. The QSFP handler would need its own payload length check.

>  
> -	mac_addr = fbnic_tlv_attr_get_value_ptr(src);
> -	memcpy(dest, mac_addr, ETH_ALEN);
> +	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
