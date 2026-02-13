Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D524E4A8
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995639; cv=none; b=lRaWL2zQfl7GJ3FKnyZ09TYweBEkdEbcWZOvHmyc8rrFjxxBnARIUpO30MC6yTJ8u81p4rKIVrZsvN7gJGhReVooX2tafuGdKqp+N6O/JiMSI7gAxrw3RvDEhjKkv6iRyvx+/vsAOKPwhzGV+Oivm3fS56FVtATijHJKNYfnKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995639; c=relaxed/simple;
	bh=3bq173aJ5nk+kZXQK+mYY1RtdGNP6XtLgOFXb3IkeiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVvpqeMZ/8g/WjZaWYF/gRhldOPCtic8eWmG2vuveY7EhwXbHr4ewpS+Dj55xsAoiZxlakdxcS9iIsrhnlQ1MJDrE2QPH80/qFxaYsy3JHeae9zDJZ9lbtz2vUmZHH76Mkz8hoD+G7o50TCkhLRgKHJCHHcZ9ym/FYknyk1baY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4jSZ0IL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4jSZ0IL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38EC116C6;
	Fri, 13 Feb 2026 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770995639;
	bh=3bq173aJ5nk+kZXQK+mYY1RtdGNP6XtLgOFXb3IkeiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4jSZ0ILRX0h9SzisEh1YWZmn6dTUbhxn2kagXrzEJlHs7/l1XLroPzUajfE8Dw3F
	 eoPNIOVD6pf0UdhzOtAc/4bZSRGsBPw3laI2Xj9galB9mpQpShnOBCboLhGcLLzoNM
	 VUC9HFi5hPF1HcJp1sv9jjrL8njpJneBPn1o7PY+foR4dflBfIbmnu9NG1s455Gcy6
	 M5XKP1Kio32x62BeloRXu8oMABUeGeKmctAPBIA2u6VvqMUaXM9AC2QRYtC2pAO/hi
	 8o7C94D0KdLTSgNWFsvd9HJVK0Li5htJpdyJXTFVOtse1+LsI/Qe9sfm3/K95JT+s0
	 VknEvxTBTlATw==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	jedrzej.jagielski@intel.com,
	anthony.l.nguyen@intel.com,
	pmenzel@molgen.mpg.de,
	netdev@vger.kernel.org
Subject: Re: [iwl-next,v3] ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
Date: Fri, 13 Feb 2026 15:13:44 +0000
Message-ID: <20260213151344.2513857-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
References: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()

This commit adds a u32 member to union ixgbe_hic_hdr2 to ensure 4-byte
alignment on the stack, preventing unaligned 32-bit accesses when
ixgbe_host_interface_command() treats the buffer as a u32 array.

> ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
>
> ixgbe_host_interface_command() treats its buffer as a u32 array. The
> local buffer we pass in was a union of byte-sized fields, which gives
> it 1-byte alignment on the stack. On strict-align architectures this
> can cause unaligned 32-bit accesses.
>
> Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte
> aligned, and pass the u32 member when calling
> ixgbe_host_interface_command().
>
> No functional change on x86; prevents unaligned accesses on
> architectures that enforce natural alignment.
>
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")

Does this Fixes tag point to the correct commit? The alignment issue
appears to have been introduced by commit 6a14ee0cfb19 ("ixgbe: Add X550
support function pointers") from 2014-12-05, which introduced both the
union ixgbe_hic_hdr2 without a u32 member for proper alignment and the
ixgbe_update_flash_X550() function that passes this buffer to
ixgbe_host_interface_command().

Commit 49425dfc7451 from 2016-04-01 only added support for the x550em_a
MAC type and did not introduce the alignment bug.

Should the Fixes tag be:
Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 61f2ef67defd..eb5bf3b6bbb5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
>  };
>
>  union ixgbe_hic_hdr2 {
> +	u32 buf[1];
>  	struct ixgbe_hic_hdr2_req req;
>  	struct ixgbe_hic_hdr2_rsp rsp;
>  };

[ ... ]
