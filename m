Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602514503B;
	Fri,  3 Apr 2026 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179051; cv=none; b=aqWYSOmQ9S3BILIojhDHt/Bh0gWq393o/uXwqpeHJzBPMhlbq8xr2MEn6FGdSPtWCR2DRgZSXF5Uk1C1pouCpvJDdkAj8+2mOayW0i0ZgkNWXyOKcrzEXgvCcNxRtZSJL6k4J42Eyv5F69+B5nmIIDy/UKygv7tqudvGLsQwQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179051; c=relaxed/simple;
	bh=IU9zpV+fhw/AVGDmlIS+prrr3RJ46Y3yClO3R5MZOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftKXQjDavdXOCO7eLys+AzqTD3VlXEzgxtsJ2h2bTENbfYuQb/sYgq1UE/hQfI89OMfvzCOSBpvZLPG4GLf99J0vrHAEukTGVy/myFFTJxEpe1DR8LqC+u303dbv9mzvKB0RNb6JHQpELqlotG/wQTdAtyr+w1GW7PrJGUK7h34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvBhotl1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvBhotl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1375CC116C6;
	Fri,  3 Apr 2026 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179049;
	bh=IU9zpV+fhw/AVGDmlIS+prrr3RJ46Y3yClO3R5MZOJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvBhotl1IEvyAFT2T/qEv9rf8dWP9JNEuuEOqn3jzMpIQEMFOgSoIlSrwyysbQJH6
	 4ZdUqynMTLHMzK1zM5kGAHNMAaMIVREs5KvkRHA/m7Vl1cFyB1OsaDjbKB72LGmYO8
	 NvoiXno04iCv9rJ/c/rN1K0DjJEPOWRwgkY3hOBcdws4kU5zx2P/8KdidjDb4eOd2d
	 Wkroi3b2cTFnMOunZ5dbeRfzIcwt4klfueHVLjUfXCVM+MVYSyOIhoH2RUiGKB4dxW
	 NU8QdrlH6J1+lTqPGxVX15h8OmVA+ETYG4W5EDjYM34q7HZeDAvjT/uFvWObt4pU0x
	 Mm9Aly2jvUauw==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 04/14] net: enetc: add basic operations to the FDB table
Date: Thu,  2 Apr 2026 18:17:26 -0700
Message-ID: <20260403011727.1795379-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-5-wei.fang@nxp.com>
References: <20260331113025.1566878-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: enetc: add basic operations to the FDB table

This commit adds FDB table management operations (Add, Delete, Update,
Query/Search) to the enetc driver using NTMP version 2.0. FDB entries
are managed via the command BD ring.

> diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
> index 916dc4fe7de3..a9f3e6cbf422 100644
> --- a/include/linux/fsl/ntmp.h
> +++ b/include/linux/fsl/ntmp.h

[ ... ]

> @@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
>  	return 0;
>  }
>  
> +static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
> +				      const struct fdbt_keye_data *keye,
> +				      const struct fdbt_cfge_data *data)
> +{
> +	return 0;
> +}

If CONFIG_NXP_NETC_LIB is disabled, will returning 0 here cause callers to
falsely assume the operation succeeded and proceed to use an uninitialized
entry_id pointer? Would it be safer to return an error code such as
-EOPNOTSUPP for stubs that have output parameters?

[ ... ]

> +static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
> +					      u32 *resume_entry_id,
> +					      struct fdbt_entry_data *entry)
> +{
> +	return 0;
> +}

Similar to the above, does returning 0 here leave both resume_entry_id and
entry uninitialized while signaling success? Since resume_entry_id is
typically used as an iterator, could this lead to an infinite loop or other
unpredictable behavior in the caller if they interpret the 0 return as a
successful read of valid hardware configuration data?
