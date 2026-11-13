Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567130;
	b=ZgdEw+bjGcDIQ7uJrDXN9ee6PYuz6Y/Lc8TRXXb5w2mBB9D2xJ7neblQ33uLoZ3hnwW+
	 UcnXfIjRP+A9/Ut9+Zs3UUncAGQ6nhREF9f95KbDmC4gc9lEk2RcnYdwyM2Ed3FXOPU55
	 hS9ahE2ANzq9cofr4qcNoEZ5QDy8xZz8FfjgFP3eb1mQr/mszUw/1OMC0CBiXPyA+iHUq
	 RgedJAKa+dLFSdVA47DA4Rx19kQxV7BialkhYLD9OW0n7rUhkmuWQtq2mIvXTHdNvk2/P
	 gKV+9qCoCw2EucgEYHWlVsFFSV0hSKsFDZCZJ5D++jmGF/h6LpOHVVSv4sBiUaizSiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6LE1z7gowkT2QwQ9Xe8s2BLaMMnQ4E5AzDFlKjo4x+8=;
	b=mEvjuOx5377nIPmXw0Yxu+citkDwuioZBUMJ/WPgPUHVXuJqlpnMj19X6oso+qIFZ7Wv
	 UbsrhXiLD2ntweuozf2ifcZ4MKR4ZSoUeRbhMnwa3FjuouyLmq2sl4Kstd9dAQMKVeJHv
	 4xUp/vv6GStpYuWxkSsLiu/gFJhW//kYhTR2yNCyjki7GU8jIP1PZl0JuunmlkgemlY9n
	 V+zUz6BRVKFG9Wd2uZM8ygRV4pH2i0vgdR0XYawGkHW0OxA5U5gsDqvdV2DxYU8VhxGC5
	 seKtbbaOQXLDH7q+YO1k+N9zNnVko2NCot3qdI8rsVxby1DJvtrrrngsHylY0kd+O7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=RbILq5eE;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F877606A33D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F877606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=RbILq5eE
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso10392451fa.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794567127; x=1795171927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6LE1z7gowkT2QwQ9Xe8s2BLaMMnQ4E5AzDFlKjo4x+8=;
        b=RbILq5eEFtD/i6u6LFi3wa8pqHNSFCNRiqRrPQbfTCOivDKqSRvDUGLIdYkM9rdRO0
         mDO1zRNspwgsxmI6FZXpFxhTl3zTCKLQBmQ4CPPb382vkwjbQO7t7Ep/Kb7ZloNg+iv6
         U9UEV1E6nBJYKrtqR7mTZ0c6+6FBOM2kpuLg+Z+2bQ10exP27yVHmHwEz5VkPW+8uUi2
         nU0R+1RtAqhIugbWe6kE7Q4sHFy7GwnO5lIbxWMY1oeQdpFDBYoiVmv7rdmrbElp9u+i
         WM4njKNGbudwGtmsF6IxAGilqTqMpKCd7tdpfCC0vXWq1RRnnJPlviAWHTmFAx2AxzH7
         FLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567127; x=1795171927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LE1z7gowkT2QwQ9Xe8s2BLaMMnQ4E5AzDFlKjo4x+8=;
        b=FR2A6SSdjKQ6TXFK43y/Y7dKTKsq68l9992+5Yxmh1oNhxzsFGvGj6M3w8r0aAdhen
         uqrWuf8gDDZBYXDrVxoJ6aJkZ+fIyI8fRqxRZOuHM7Bs/QdrBZoCy95xF+iFPp+gMAYp
         L54im8rzfxWTXQLeA3fGmoMpTMAeeRWcuQ4rJOBkA9ngY0O4t/gljOHwlO5s1otTW6a9
         iy0rX2X3x9SjaBdu8tvZCYhqvd+Bl4HPgtmE8txsrTHt8HNHYml/bjVqFqx9o+Qrzz89
         kxqPp2OvkMfL8jfmRczUnd+rClPGQ2HQIdwhcegBg/p4WeOhWtL9a+o26L8wWuuIrIi/
         BOlg==
X-Forwarded-Encrypted: i=1; AL+hErEp1STRlxi0fsUcwNtebNxXlwzf6ddntmdQaBwAj9br8rD54SWZGkOF+57I8uA/0H4pzdi4D8w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cmFMRWOLm7Dk2lJqrda58Pj4GeZW7tYUAJqFdqYIq4xxilwgU
	GTyzzD01EjbAh7DnktqjV0xeVEl3oeMsE8fSx9s8KgxE8GOn5fkSekGvei/QjUyE1ug=
X-Gm-Gg: AYBFou3JOSZ8xQefJdWEVNi+BDZyBVcJE4SZgMvZfgN6KfGmLcxt/Ewm6+RkMlIA9wf
	6c1BI3EpCrLRkUbsvKuMdPjdhOQjG1gksoMpDlL6BNEe2uppxnqG4Vz/1FesIR/Tpc8JyBTNbzo
	YedjldzWgkpTWYpSx/IFhCxL6izq8JniICvy24nNw+HAJzkJzodR7bJX2elT/VJtedQWueOMg5u
	cgFvuuwwxqwoB5CLcp16dMRKNJGfLqCdIh30XmVnLZN+BGTyj21YrDUq1XVqy1nJktr7TpohsD6
	ijy5rxshI2p/kR7MEez6oMQsxMhzKyBeJO4wUBkUJlBgMYbMFwWalRt0X513IThKSSTTHanDcy0
	nbFClr+cPw9lG0IMgqZeTKK9Azk90Fn4gRw3cr4HJ7jZ/215Jb1vKOg144gr/CuQAEylBKyi9tI
	+iU37OfqlU744xygDMZVCtzu+62NgXP0rV+ZJoxrXpLp0zuHMKzau+S/VuSI2GeV/dbKUHWRPQM
	3aWmR0RjUCqBGpWt/Km06wkV4Pf8Sq28yXU7e34Cz/fy7D69rZSq/62mf96p5J4Yx+vGNsWfTKg
	m/sXWtiUQecHCkyPTvbqsMPKCtOCNFSVlOymPQ==
X-Received: by 2002:a05:651c:211b:b0:3ab:1639:9a75 with SMTP id 38308e7fff4ca-3ae2b4efaebmr6838051fa.11.1794567127086;
        Fri, 13 Nov 2026 02:52:07 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7ae914sm7498931fa.26.2026.11.13.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:52:06 -0800 (PST)
Date: Fri, 13 Nov 2026 11:52:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	1342116488@qq.com
Subject: Re: [PATCH net v3] team: validate the length of U32 and S32 option
 data
Message-ID: <avbrzVvksHvTF89W@FV6GYCPJ69>
References: <20261113090108.175889-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113090108.175889-1-sunwenbo@cmss.chinamobile.com>

Fri, Nov 13, 2026 at 10:01:08AM +0100, sunwenbo@cmss.chinamobile.com wrote:
>In team_nl_options_set_doit(), the policy for TEAM_ATTR_OPTION_DATA in
>team_attr_option_nl_policy is NLA_BINARY because the payload layout
>varies with the option type.
>
>For TEAM_OPTION_TYPE_U32 and TEAM_OPTION_TYPE_S32, the payload is
>read directly with nla_get_u32(attr_data) and nla_get_s32(attr_data)
>without checking its attribute length. When userspace supplies a
>truncated attribute (0 to 3 bytes), nla_get_u32() or nla_get_s32()
>performs an out-of-bounds read past the attribute buffer. Conversely,
>oversized payloads (> 4 bytes) would also have trailing bytes
>silently ignored instead of being rejected as invalid input.
>
>Validate that nla_len(attr_data) equals sizeof(u32) or sizeof(s32)
>for TEAM_OPTION_TYPE_U32 and TEAM_OPTION_TYPE_S32 respectively, and
>return -EINVAL otherwise, consistent with how NLA_U32/NLA_S32
>attributes are validated and similar to commit 5bef3ac184b5 ("team:
>better TEAM_OPTION_TYPE_STRING validation").
>
>This issue was identified with the assistance of an LLM-based code
>review of Netlink option handlers in the team driver, confirmed by
>sending malformed U32 (notify_peers_count) and S32 (priority) option
>attributes on a UML kernel, and verified after the patch that
>invalid lengths (0..3, 5, and 8 bytes) are rejected with -EINVAL while
>valid 4-byte options still work as expected.
>
>Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
>zero new warnings or errors.
>
>Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
>Fixes: 69821638b274 ("team: add signed 32-bit team option type")
>Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
