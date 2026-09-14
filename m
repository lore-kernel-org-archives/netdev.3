Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4875439354
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422294; cv=none; b=FxxzFbc4uh8ngTLuXfJe10VTAmycKXn6HkbS7qKCRtqfzfjHpj556Es8rmBE/YeHbNzANpfKHUhP3Apy8Yc7hyoMrS9jtJC0gMoUpiyRVh55xPhrk4t8+5e15iDTliN15w4bnRTh+zy4jItEfrmfFEhXZzjho+HBDxQdGcaz8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422294; c=relaxed/simple;
	bh=jj7tySioSR8Ku9oTtm142cyvZWn1Zo3/dc/BMfq7jNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET9t7c0voXKKGwDPu5/kli4VRQAqKhnEdQuawpIhhRMQo9TQOMpcwCLgImk4g/P2/BY1PcefNmhvGA1oD0v0iyEFQRd7X9JnN9aNVMhiY+ffdfVI3P8SKi1Sy8DnjBMURVLTyRNdhf77bqvY8MJCFDzWgfo2ljjIG5yk1Vowym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso16091105e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422291; x=1790027091;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3kow1pwp3tGgUJHH/7cadVBA2cQHHUCYstxSQHCM4S4=;
        b=Rd+n+0Oyfh4hWZYRhsOD5qJl5Wqx9bJhLFfOegI527ljz6aT9GBzsJhOgt4scNnYn1
         cCyJOG7OAatFFvf4dIl/5I0HSE7S88CvGdmvcaidX378Bcb+izFlItGm6R6LuxKqBsu0
         d157oEShhwDi4LVkfre2G4wJkBvCVJYOhrXoGsSLKDrv7XRdwJagk8ksTt3wCNW7wEpb
         vn97dBpt4HqkvBd7ngaQMyXoif4F+RaG+7zvggrjDkb/hfVg2WxMA1koz/j1arTTLOIh
         BWwjZYdnTdyhyhq4gYf1TGcEFeNmaPVminr1APPXgenAeYfMckhx24RHAZT7rMqBTR5Q
         yj7w==
X-Forwarded-Encrypted: i=1; AKwUvBzZcQB5SnQWYI3lSD7q5LWbaiaAbfYj7R+/W51buojbE2nqveTdwa3tvWbo0oj6eYYV9zWJfnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k5PaXYuM66C+0AukmiedqlHFvqo2gHCiKc60X1Hh5UYT4NUIsx
	C3IMIDBIOxPfYWEtmgjC4xTB4i12qN0ekk4nwcuLpE5A6Ly8fE+ZIo21
X-Gm-Gg: AYBFou1jqZuTS9CwOU+BIYGp0qHEz7X9ZS/5wX0CguwdpyI9TGpfdlJzBC/o4Hi3DLT
	e55JmYtuvaie3jdt+UH/9n33jBtbbOg4ywQAWc94z1DpKKAYc/oinU8ph3f4uPeJZzrkgz3aCd4
	ziwAX+bkjl2ARlYR9alSomLB+8HDaRzs8fp8hULDVQeC+fNcOV7jI4ZDBOQZU2C5gj2W7w9+dK0
	jknz4RcqjJurzTCZOpDxlSze1WEMYtYMtxFZQ8r0G13ZAONckM9UXo0xKGdyONC+2TdsBgwxg5w
	rAboid50sakpNV/u0irwy92/U/XKugIcS2mkadVniMXzFRTQ927fKcEhJS3FbnQflX+fT7+9j7e
	+awEFh/KuCITL9HZJmVJJH1uuYSS0h/ko6+7d+PX+hV3XjH8gJ73DQXVronx7kLwhtaAQpJbO+Y
	EYomlN2LfFwxntKPb4doBY+xGePHMsNYVKREOTJ49dWKSEfWAnEbM2Ewi0cIxSfxr7oAhuhhPwu
	s02oyRS6LiN8QXSjjD8VxTpmaUpAzA0/lT0lQllebFZW+4=
X-Received: by 2002:a05:600c:698e:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49e7a638778mr109227285e9.3.1789422290602;
        Mon, 14 Sep 2026 14:44:50 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7eed9d00sm7615235e9.0.2026.09.14.14.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 14:44:50 -0700 (PDT)
Message-ID: <2afb49a0-3eb9-4ec9-ae6c-05491ed55949@ovn.org>
Date: Mon, 14 Sep 2026 23:44:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] openvswitch: avoid reallocating confirmed
 conntrack labels
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai
References: <cover.1789218015.git.zhilinz@nebusec.ai>
 <372fbb062b40ae6723684f55484be86ff0064f8e.1789218015.git.zhilinz@nebusec.ai>
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
In-Reply-To: <372fbb062b40ae6723684f55484be86ff0064f8e.1789218015.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/26 3:22 PM, Zhiling Zou wrote:
> ovs_ct_get_conn_labels() adds the labels extension when a conntrack
> entry does not have one.  Confirmed conntracks can be read locklessly,
> so adding an extension may reallocate and free the extension block
> while another CPU accesses it.
> 
> Only add the extension for unconfirmed conntracks.  A confirmed
> conntrack without labels now fails the caller's label operation instead
> of reallocating its extension storage.
> 
> Fixes: c2ac66735870 ("openvswitch: Allow matching on conntrack label")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/openvswitch/conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 27115967e5d93..0f433688e17b9 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -366,7 +366,7 @@ static struct nf_conn_labels *ovs_ct_get_conn_labels(struct nf_conn *ct)
>  	struct nf_conn_labels *cl;
>  
>  	cl = nf_ct_labels_find(ct);
> -	if (!cl) {
> +	if (!cl && !nf_ct_is_confirmed(ct)) {
>  		nf_ct_labels_ext_add(ct);
>  		cl = nf_ct_labels_find(ct);
>  	}

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
