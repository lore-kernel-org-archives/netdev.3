Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B3419313
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536917; cv=none; b=Y4x+VM5ZSh2EbCjx0PU7y58YHr3bKfaAAxM+4G6bdml4y/WRqChy3hIQ71atV3t88goPe5RfNvz4no8MOINAqYEjL0Z9qzQzCF9l5UEuw96xLfFVIttXh2hGKjbW06vwhWmdT9okVhZZ/Q+xpnS9g8fuCy6siy9Cyhk+WiGeqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536917; c=relaxed/simple;
	bh=vlT+YgAwAPxJUrTIRP740T8mXC1Sjs/HBWjdLsEz840=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2tD3KLncesOgZpxESQCeAdvp01jP6Z7mh8meOZD82hsfQjbxegHNY42v5yyVqYp3voDApkZrRxNlzya05CSj1hqk2ynhxSWNl2BbGXqZocFJQ5OAzJZj4hkYWshZz4WCsqFIyrEGtBSdd5scYvd3P+xqGFqmSBodhTkrAP9knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso1909755e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786536914; x=1787141714;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIxmvu9sdGC0S0qAIC0vKpxDRs8wnzbK15jb7UzSDd8=;
        b=IRKBIuwdtwUWOga+hQLX3rflpp0uHKR3JHAs48QGwB8J+r/jHnwm6ykXifO1oSXKoX
         gwPo+x+lCZyLZvz5P7+htHh6om6U+i4NSBMxVJ0Bi58hXXS/Zr2KS0WPi0mKxRC5UDbP
         K/NC3rg8RRMPrwihSWHeXMgCo5obIvsV8c+VmCzm0+S1HR1YAW7BwYTuHlXAqTax1AoS
         mYhjEAdXuxsRDvm1CSrFEC1Zp6RUA7vOX2lwddQbayOcXUMXClSC/UhUGl3E/0Etj51O
         4zOdRdHwnM03J1MJjaFjcyL7S1KEYMaLe9cPZdEeHvptSOv7ajd5zYlBUIsNBnql3Q3p
         DOWA==
X-Forwarded-Encrypted: i=1; AHgh+RrvSC+H9LsFbCr5TRgHVHUxdv0bZSedX2svYWJt2W0t6fi5R/KAzszw0WgSkgI7R0xK4o2krHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztBnSIpXkdLjLIM5ejxTsuiBWLv46EPOBg9b1QP957Y5RmosC
	yWfPXafSs3bNbWZ7yH0WIbNK56S1Ji+P+gvmaUSe52yKLAoMuiXECmHA
X-Gm-Gg: AR+sD129h8RE01khQltJul8uzaCe0NPjlppY39iUJv9JZBr/e61PJdZW4D4gIxiMTYq
	7w14jiWWe5MaShq9+zGx5k9U37CYa4CjiZg7kfUijpStGwAe3IuO22ZxLPP+Un1Av0sPHwqmvxB
	JK4c5jwXORkWToQo/U7GgeuYM6QKzipPdnnIGR3oPLgwmSt0glfAAcIEQVwJt+SpYbe0yH+G/J2
	dU6f7pBBLDsFBWJ/4wA1u10g4ypkfbVkTKyrJMCzK0+BEyjSy/1ZDTRp+WxoRaIjkncR2W76c5m
	Da0pZoToasv6uLuYLDZmnIuCxdUJAZePYQN5ZSmO0u61gxUxYD3h+AmDcwS1CaEt8KfxXW4+uKM
	YOYijJyxBM2cQDVnLXMiqc3+s3EPB+O/5Jm57/UX/1VWEh0DGk3V5Bz5lNV/EhFAZY7bpkh2CWk
	6BHBJY454bXdlCi7XEFHfKPwlVRGUufr55jDakM7yrS3DOKVF7wIkihPjMJ+OvJNdSpCcHuuLWT
	JVD6PHthcsCcPpkIbPKr04K7W3o
X-Received: by 2002:a05:600c:c4ac:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4997c0f0472mr50392525e9.5.1786536913754;
        Wed, 12 Aug 2026 05:15:13 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf412dsm7582551f8f.6.2026.08.12.05.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:15:13 -0700 (PDT)
Message-ID: <12c4319a-c3f2-4b64-bfbf-44cd5722055a@ovn.org>
Date: Wed, 12 Aug 2026 14:15:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1786506548.git.xuyuqiabc@gmail.com>
 <a265fa4d69ec48176312f98381f8bb43347fcff1.1786506548.git.xuyuqiabc@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <a265fa4d69ec48176312f98381f8bb43347fcff1.1786506548.git.xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 11:59 AM, Yuqi Xu wrote:
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> An unprivileged user can trigger this bug from a user and network
> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
> netns is torn down.
> 
> Publish the CT limit pointer through RCU, remove it before teardown, and
> wait for readers before freeing its contents. Keep ovs_mutex around
> individual CT limit updates, and use the RCU read-side lock while GET
> traverses the RCU-protected limit lists.
> 
> The netlink command handlers do not need NULL checks because the userspace
> netlink socket holds an active reference to its network namespace while a
> request is processed. The per-netns exit path therefore cannot run
> concurrently with SET, DEL, or GET for that socket's namespace.
> 
> The teardown path currently waits for the RCU grace period while holding
> ovs_mutex. Moving synchronize_rcu() outside the mutex would require
> restructuring the teardown path and is left for a separate change.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
