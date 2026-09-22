Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD37B3F7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042162; cv=none; b=ZKHi9cQ8wkNuXRfC/VusioIlWdq4vkx6d2r0QNwGCcPVfIC1M7cFyB+DGbH97sB2icOzLQLdY3eBJKZTz8Kdvxy4/UZVBeEoPRqtR1QAvYJfq2cFm1/QaslkrK2kJLHWeM9Hvf4LyoYeWFddDHafZr9Z+95s0OLgab+HrzJ2DL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042162; c=relaxed/simple;
	bh=zFLW/mMYvm78J+sDujqQplOT29MqtwWIURnFbbzNVU8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoUdKi2l/du5eT6iasNgQ2zrLlB7k7/zmMTWflXo1PqzVooHkkShwQuMLSHZIticU7NsFlbCM9fjB1lPt9Q9B1wKN83Fs3utkCCjIgJoNBG5UtiWiHXsJdIiPRIuaWKaNqCYZ6EsRSHrQmL93KuF+9iqU6Ctdzm0qWnpAc19blI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b299aP/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b299aP/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5718A1F00893;
	Tue, 22 Sep 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042160;
	bh=b0OmOGCHUBeJsXI2lwWY1QhpBnwZpuAOWWn+r+4yC9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b299aP/pO2F5PdGVAtdzZAPNzlwgjjE2SMjm8RrIA2oRSbrlffqn1qSTzJIUQ1HOz
	 KUaCvp/hRK/bptPSJk2VhZ4mpdApRdLDV9B8SMs5UpLRa3UAKqbT5phpSMlQ2BkGbC
	 oJEYjSJTslSlH0GeWCRMS34pbadHbrzMaC6mh8ZMMSVP45BL8lYjW6LoWBfaHA97Oe
	 OZ+uyTqin0aXrPbJK5xj2WWitfPUBfpAYM+Qsy3WWg+MoAtEt5UHPeIS0TYTitC5XM
	 +1YiMRpk5YtThVVngm2bBAVBo2oRAzpd/iYIvc+mJJQ2bYz58RIS75uRfmjKyVuCPh
	 JIMB4QmT5xrjA==
Subject: Re: [PATCH net-next v17 02/15] net/mlx5e: add TLS 1.3 hardware
 offload support
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:55:58 +0000
Message-ID: <179004215886.2160803.3872789531181206919@kernel.org>
In-Reply-To: <20260917224355.2288021-3-rjethwani@purestorage.com>
References: <20260917224355.2288021-3-rjethwani@purestorage.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern (INVALIDATED by series context): 'net/mlx5e: add TLS 1.3
  hardware offload support' is claimed to be dead code because net/tls…
- [Low] Concern (no defect proven): fill_static_params() writes the TLS
  1.3 8-byte IV tail into the device's implicit_iv field by pointer…

--

net/mlx5e: add TLS 1.3 hardware offload support

This adds TLS 1.3 capability checks to mlx5e_is_ktls_device() and
mlx5e_ktls_type_check(), and teaches fill_static_params() to program the
TLS 1.3 static params context including the 8-byte IV tail that follows
the 4-byte salt.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> index 07a04a142a2ea..0469ca6a0762e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> @@ -30,7 +30,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
>  		return false;
>  
>  	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
> -		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
> +		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
> +		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
> +		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
>  }
>  
>  static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
> @@ -40,10 +42,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
>  	case TLS_CIPHER_AES_GCM_128:
>  		if (crypto_info->version == TLS_1_2_VERSION)
>  			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_128);
> +		else if (crypto_info->version == TLS_1_3_VERSION)
> +			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_128);
>  		break;
>  	case TLS_CIPHER_AES_GCM_256:
>  		if (crypto_info->version == TLS_1_2_VERSION)
>  			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
> +		else if (crypto_info->version == TLS_1_3_VERSION)
> +			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_256);
>  		break;
>  	}

[Severity: Low]
This isn't a bug, but could the commit message mention the core dependency?

At this commit the new TLS_1_3_VERSION arms in mlx5e_ktls_type_check() and
the TLS 1.3 branch in fill_static_params() cannot be reached, because
net/tls still rejects 1.3 for device offload:

net/tls/tls_device.c:tls_set_device_offload() {
	crypto_info = &ctx->crypto_send.info;
	if (crypto_info->version != TLS_1_2_VERSION) {
		rc = -EOPNOTSUPP;
		goto release_netdev;
	}
}

net/tls/tls_device.c:tls_set_device_offload_rx() {
	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
		return -EOPNOTSUPP;
}

Those two guards are dropped by "tls: add TLS 1.3 hardware offload support"
later in the same series, so the driver code does become live by the end of
the series and there is no functional problem here.

Since the message says "Tested with TLS 1.3 AES-GCM-128 and AES-GCM-256
cipher suites", would it help to state that the test depends on the later
core patch, or to reorder so the core change lands first?

Related, mlx5e_is_ktls_device() starts advertising kTLS on hardware that
only reports tls_1_3_aes_gcm_128/256 caps while the core still offers only
1.2 sessions, which mlx5e_ktls_type_check() then refuses. Is that
intermediate state intentional for the two commits it lasts?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> index 570a912dd6faf..f3f1be1d40343 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c

[ ... ]

> @@ -15,8 +16,10 @@ enum {
>  #define EXTRACT_INFO_FIELDS do { \
>  	salt    = info->salt;    \
>  	rec_seq = info->rec_seq; \
> +	iv      = info->iv;      \
>  	salt_sz    = sizeof(info->salt);    \
>  	rec_seq_sz = sizeof(info->rec_seq); \
> +	iv_sz      = sizeof(info->iv);      \
>  } while (0)

[ ... ]

> @@ -59,7 +62,12 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
>  	memcpy(gcm_iv,      salt,    salt_sz);
>  	memcpy(initial_rn,  rec_seq, rec_seq_sz);
>  
> -	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
> +	if (crypto_info->crypto_info.version == TLS_1_3_VERSION) {
> +		memcpy(gcm_iv + salt_sz, iv, iv_sz);
                        ^^^^^^^^^^^^^^^^

[Severity: Low]
This isn't a bug today, but would it be clearer to address implicit_iv by
name rather than walking off the end of gcm_iv?

The layout is:

include/linux/mlx5/mlx5_ifc.h:
struct mlx5_ifc_tls_static_params_bits {
	...
	u8         gcm_iv[0x20];

	u8         implicit_iv[0x40];

	u8         reserved_at_100[0x8];
	u8         dek_index[0x18];
	...
};

gcm_iv is 4 bytes, so gcm_iv + salt_sz with salt_sz == 4 and iv_sz == 8
lands exactly on the 8 bytes of implicit_iv for both AES-GCM-128 and
AES-GCM-256, which is why nothing is currently overwritten.

The write does depend on salt_sz staying 4 and on gcm_iv/implicit_iv staying
adjacent though. Would using

	implicit_iv = MLX5_ADDR_OF(tls_static_params, ctx, implicit_iv);

plus a BUILD_BUG_ON() tying sizeof(info->salt) and sizeof(info->iv) to the
field widths be preferable, so a future cipher suite with a different salt
size or a PRM layout change fails to build instead of writing into
dek_index?

> +		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3;
> +	} else {
> +		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
> +	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
