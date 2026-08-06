Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240738E8A6;
	Thu,  6 Aug 2026 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980509; cv=none; b=IY5btviU7YsFxpuMvUzJEBzAUkotl9cwUMBOMuBDOX3BKHcSqgUY8I2HwX6XUOGrnwGaJSlnkwLWylF4RPxOvir6j38UBu6whd3NRW/KPK8Ae9e9/v8A6euYfVRokhzI6baGyX5/XznH6sqUb8r2IiyPe2h+KLpx0bkxXzL7jRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980509; c=relaxed/simple;
	bh=Z8pSafNOAqax5ZqdkdD0IPsp6BXNbwWWVegzB4VsHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naI/TdmAoHObol3J8Wsyezw3zy8716X8GGfYAtzBJClgfMnpkO8OpEMRRcMjaw4zYcxmquF9dkU1vTJJfQr2o2dKhaoOI1BMj2E/dnXFfHBlvRHbpVgLu+RChqUAiLTpLmd5GJ5u+WhvXCCoZDqtTZXLZSq4LOiABwhVuKC1TAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuHYMxio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuHYMxio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF0C1F000E9;
	Thu,  6 Aug 2026 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980505;
	bh=bbtX5EsCgoWc8LHUPXetPNhgykaNjaNNsuqwDq5Se4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JuHYMxio0ws7heIkoocL+39HVbWkdwhw+NkRMahBD5M1G3lGp+/xCgJ1mqAvS9Vai
	 KiT7t+NbqEn9M/lG+gvR7NbIxtoEYK8MbIkP+XAAdftDnZVKET/PgOcVvjvpYYjTkL
	 9mFMBstkKGGxAAfQrBu+32NH27sCoNrnkIR1bKYHz6X4zlLvhnIgweXNK8oic3qbBn
	 SQso/u/eio0TUEVr5WuVddAxsuHyN3kB3CersFIxcs0Q5W9lG30dzrSE5X78Wuhk/n
	 9a4rRw19a2icqWozb5ic6Y6PyobUl/g2JO1Q/FDLepLQ9hbGEtq4lWEQrM9RXLh7kb
	 ssW35H7s8yX0Q==
Date: Wed, 5 Aug 2026 18:41:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v23 net-next 05/12] net/nebula-matrix: add common
 resource implementation
Message-ID: <20260805184144.08c5b4c2@kernel.org>
In-Reply-To: <20260731094242.2655-6-illusion.wang@nebula-matrix.com>
References: <20260731094242.2655-1-illusion.wang@nebula-matrix.com>
	<20260731094242.2655-6-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 17:42:28 +0800 illusion.wang wrote:
> From: illusion wang <illusion.wang@nebula-matrix.com>
> 
> The Resource layer processes the entries/data of various modules within
> the processing chip to accomplish specific entry management operations,
> this describes the module business capabilities of the chip and the data
> it manages.
> The resource layer comprises the following sub-modules: common,
> interrupt, and vsi(txrx,queue not contained this time)
> 
> This patch provides the common part, including the conversion
> relationships among vsi_id, func_id, eth_id, and pf_id. These
> relationships may be utilized in the upper layer or the resource layer.
> 
> Key Assumptions:
> - nbl_res_start() initializes VSI/Eth/PF data structures **only for
> control devices** (`common->has_ctrl == true`).
> - APIs like nbl_res_func_id_to_vsi_id() **are guaranteed to be called
>  only on control devices** by the framework's dispatch layer.
> 
> Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>

This generates a possibly transient warning when built with W=1

drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c:68:2: warning: variable 'eth_bitmap' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
   68 |         NBL_OPS_CALL(hw_ops->get_fw_eth_map,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   69 |                      (res_mgt->hw_ops_tbl->priv, &eth_bitmap));
      |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/../../nbl_include/nbl_include.h:39:6: note: expanded from macro 'NBL_OPS_CALL'
   39 |         if (_func)                              \
      |             ^~~~~
../drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c:70:6: note: uninitialized use occurs here
   70 |         if (eth_bitmap & ~((1 << NBL_MAX_ETHERNET) - 1)) {
      |             ^~~~~~~~~~
../drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c:68:2: note: remove the 'if' if its condition is always true
   68 |         NBL_OPS_CALL(hw_ops->get_fw_eth_map,
      |         ^
../drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/../../nbl_include/nbl_include.h:39:2: note: expanded from macro 'NBL_OPS_CALL'
   39 |         if (_func)                              \
      |         ^
../drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c:56:16: note: initialize the variable 'eth_bitmap' to silence this warning
   56 |         u32 eth_bitmap, eth_id;
      |                       ^
      |                        = 0
