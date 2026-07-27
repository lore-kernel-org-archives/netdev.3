Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AC3D8123
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181725; cv=none; b=fkybtk3Y864LtP2Hyv1YTWlEpJHtByX0Wl2gSh6sTU6vfLrlYX6RolxMVeilVV3kFyTxzzTa/l0LgGf7/QrMWBnJl6XWDmWC5lqAxJwTlrWNh1NtL9XRfuBYHTNZqr2SIYi325XQEv0gf8hJ866CagvF8XR+RjCKPHA6OuynmC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181725; c=relaxed/simple;
	bh=qCWfEA1b1R5RfRXxJrVb0UKyd+iQlb4ns4bdtAmOWIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOfO5FB+ZAbDAoG3yD7dQKwz/8Nhz+unbjq+jxA16n/Q8VAvLUwjucvh0+/4LusSg9BH+xE5LJR9zSmtOmE+2pNBoNCuMqQ8mUYoWL5WItLZ+CCXckO79oYnfnSwT/XlBF+cR8xqDTzMPRnqbWbpUzJ6f30d5VPDGmhsFRGOsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so729081f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785181722; x=1785786522;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMNLMOjXVswq8wjbib9cEYne4Ga97BQFsJxzqPndqJM=;
        b=dr5a7d49szROQ1bJR5Sn3McFLqDGhV+ivZEqVEEgvB8fi4GwUxBM73ozCdALEucJOR
         1DIzhMKy3xuFK/JDMFC2tgNrd2VWLKlOj0HKZOiVD7psG85o3PUjOmkvBtItOTq82SPo
         DUpGwyNv1rOwZgt4SvLlTasaUZZ8olgjeo2XJthUmvcQJSElwdXU1Jkpiap45aQ/Vi90
         pXfRZe3q5oOdIZBKrVSI4lJV82REFuYv+6ibph0UAyZwrfbA2lScx9wsnRp+KvNfgy1c
         NoTgj1V1BxRqMrn40xDXsxkGrAUeEDztNT6aHGdl5Id5Qmb1rSusaL/5VunuRZUJWHJb
         QwRw==
X-Forwarded-Encrypted: i=1; AHgh+RpK11G+6k46QYLHEcoQJxMAosNSf+3PMycO4dE1/ZQm46dTqJ3DHUMjY4IWfKfb/Hw0ewlvaqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpniEuLbc4c52rrG1e52o6817C8O4k6qChan+Um+rSRn+hsuQD
	jFkQFCgqJxTCZU9lPBhck5xteCbltEo10+VHlEy5nM1dAc0Qa7eXvuCt
X-Gm-Gg: AR+sD12B92DG37BksBmx8E8rjtFvZX9D7ovFhKP2t9b8I4YERLakBWYEGa93GoKoYBL
	QdrGviMRsd9ecY21QIgQlr/N0jAggQc2Zc8HfM0Kjq28eGW8HG0AGjeG4G86wP7xdru7x5fkMLQ
	vkUEla3LzF+mh3v9TBltvNUVLSF5Kh6kaZRQdXGNS7+JJw1+B7x4X2MzWU93qalUPV+HzDIQpAx
	dwDoOoWpcv7eyg+WSuplEhUGk8v9Q6v905KjTiQAp7mgO8zr6RhtE7yXUD8l3JvA7dpDU3n7/M0
	E7vliqUKvxoAm/05KcHIHNpIhP5GrMDxTATV64GMNi9RV4K7JfL9BVgZlSP8jUY1IHbGDMISTFJ
	NUFGCeTWEEwgQ1k/Uh51rNKRv9h1pFAXQXiNpi50rQKmy5KTWYn4io0NEc8FZaYJZeFkX+Ka0kS
	50VTR+xvDPremblTBXnAddkXLw/4sh/975hkY5ag0=
X-Received: by 2002:a5d:64e7:0:b0:47f:91eb:33b with SMTP id ffacd0b85a97d-47fafa9514fmr534175f8f.48.1785181722158;
        Mon, 27 Jul 2026 12:48:42 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm56755775f8f.19.2026.07.27.12.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 12:48:41 -0700 (PDT)
Message-ID: <a70e92e0-8c5f-46e8-85d0-be82e34ff87c@ovn.org>
Date: Mon, 27 Jul 2026 21:48:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: openvswitch: reject mismatched flow IDs
To: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, joestringer@nicira.com, pshelar@nicira.com,
 vega@nebusec.ai, zhilinz@nebusec.ai
References: <cover.1784881178.git.zhilinz@nebusec.ai>
 <fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai>
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
In-Reply-To: <fa4f85fe7becb164a8a1849aa77ceeb1c08b078c.1784881178.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 6:52 PM, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> ovs_flow_cmd_new() looks for a duplicate flow before deciding whether the
> request should insert a new flow or update an existing one.  When the new
> request carries a UFID, the function first looks up the UFID, but falls
> back to a key lookup if the UFID is not found.
> 
> That fallback can find a flow which is identified by a different UFID, or

UFIDs are optional and it's the user's responsibility to make sure that flows
with the same key have the same UFID, as the key is the primary identifier.
It is valid to update the flow with the matching key regardless of the UFID
provided in the request.

> by its key.  The update path then replaces that flow's actions even
> though the request identified a different flow.  If the caller asked for
> an echoed notification, the reply skb was already sized from the request
> identifier, but ovs_flow_cmd_fill_info() serializes the matched flow's
> identifier.  A short request UFID can therefore make the fill fail with
> -EMSGSIZE and hit the BUG_ON() in the update path.
> 
> Track whether the matched flow was found by the same identifier as the
> request, and reject updates where the identifier does not match.  This
> keeps OVS_FLOW_CMD_NEW from retargeting a different flow and avoids
> building a reply for an identifier that the skb was not sized for.

This breaks a scenario where the userspace components are upgraded from
the version that doesn't support UFIDs (or has them manually disabled) to
a different version that has them supported (or enabled back).  After this
patch it would not be possible to keep working with the installed flows
without removing and re-installing them back.

A better solution that doesn't change the logic would be to just free and
re-allocate the reply in case of the identifier mismatch.  If the
reallocation will only happen in a rare mismatch case, it should be fine to
do it under the mutex, while keeping the allocation outside of the mutex
for the common path.

Note: reallocation should happen before updating actions, as we must not
fail the request or fail to reply once the actions are updated.

Best regards, Ilya Maximets.
