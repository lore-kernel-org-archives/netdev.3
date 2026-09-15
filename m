Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564731B823
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467983; cv=none; b=FxEsqsagmW3Yi8ShlqagIHC+LfIUUuVkc3XBYCsAlH4966grfcLKE1IBFy84LNwpyVbgkdUA08ysrkiyhn6wuS8QIK69QJN0PgTwuNIl5FqaZme82AAKUYUd2bQCDHDTo34x9rKPM514kmOWKqxbx+ZBzRG0q0EkGxFDFf3T1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467983; c=relaxed/simple;
	bh=Km4iOXUDzEA/paiw4gBm8sJ5RUhR7oNFvxSF0WlPpX4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qWf88SjdLOw5oxBCGDO1yojhING/S2aQvj51zWYoTeXyMSZmuArnsUMKlhDwzuYCnDc2DGuEFyx9Rkkp1Li38V8wmPAjXIh+dE6BfDU5dyNFheu2wrO/h7EoClxaTRrGLivwI5Kec8VtjqH9pAvuOJi6R6GCx2HNCsLg/GrKVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=jFGjkcsR; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="jFGjkcsR"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so14106795e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789467979; x=1790072779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW6Angy73DE+FcoQnAj7AGMpu43bPwy4fXJShfDRPu8=;
        b=jFGjkcsRXHgwFZh0KOUeqqWuDZAW55Xsq6ag2IlhQuSvP4HaRXFFzcD0JV1OaQNStt
         sqedobaYb8TvTrOLQHCkaTXVs19zt8EWCK5pgV3et+l+fhmCZyBZibaowtNUEvPcbOFW
         6lseAmGuyWd5oaiUWmY2EYJmsVcjw7KAFale/nAq1T4/P9vrd3IVOFcdb/NaNsGfpoSg
         n+rkQSola2UVthG+UlBRTdxT1h0Nkw3Feun3nkcllT6sy2ijRI31XpCtOe9z2kMNXNzz
         ztcthB/sXWfFf6qajf+L2VVirYZJZyqwMoFLA19rfpk5/+1wX3P4paiGeJiYHPq2yZ3u
         shSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467979; x=1790072779;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW6Angy73DE+FcoQnAj7AGMpu43bPwy4fXJShfDRPu8=;
        b=MN01gjdOaRcb1uZO9FO779OpQjL28xS6aQ/UDFIjz/MiZ6Soev9Pw9wfNUQZ3eogIO
         LDdFZ6FAurvXDYPu+Op3asENY7PVtodmhgqkyURcl73uDtb6PZjzzai5GY7TccaM7tMr
         Dda7zKcIgTVF6+9guQ/KV9+G1fz73PqfFVfolH628yjPR5kVIlYWed7UaLC7KD66J2Br
         rifpGeMvwoq7TLuFibm2gkRhA7WhIhNDEEvOWnyJAJTD3pvUQlUMcqRHjl7tgIe9Ca/I
         jGvRyoxHtFcUMOu5Mwq0PtHDChzEzbi9RjhRhXvoG33zOPmLpA6ArFDxwHpTHIuflOwK
         PsNg==
X-Forwarded-Encrypted: i=1; AKwUvBxbFdBm0obQHob0PbVU+jJyDPcnOZuCFA8E3cQdpWjufaKHjbNLJhL4/sKOAPGpF4oLpM+dZ9M=@vger.kernel.org
X-Gm-Message-State: AFuF++lZR4KS3R9AwIi9sOV/IBzsH/I9SgIAYeETCfZN4SCM36s769zL
	l8P45Vg+97EPJ18UBuxIBFIwxHgGRcYQbWcX2Li0O3JGOiYKKXfot7dOddheOl2oHkM=
X-Gm-Gg: AYBFou0pE/K0QK+MLfzQw6LcpN/+dQ3CqOFEzHQ8KCBFnvGim6URIqB51MJEILaa2kb
	0MwATnzuXDVJbiTyD0Vs9qudA8aetmuTMUfHTOx0Ua/eWJANy7zZYWU/N4sMHesCBXj0AKFUpmt
	X0ypJB54nJY3fYzgIGNVkT81Xj2rKFGdxD+tdAjweS9P3SPxVUaM9uOS/JZAixeP2DbDF+9XPyA
	+HRBkHaGjQ/yMpJTdV/txxVEyuM5gxk279lDG9I5SQq4JN37O54M0t8AY1DlNG3/4I6k4wMMN9B
	whsqsOo0nP4RepOvM5LlAN8SIwrWb2vBhzzVPFExQC8Fx0pbNh31ht3zJLJXs/TMNQxcr4gWCj/
	2tLKwI2JVRxfpjKFydx+SHX8Kz64mNoXsWdvJoz8EAS3DXgS9DVBNichCHoQjgAGYnQOE1ZGCs3
	jevjWrc1zwU74HHESMrFLOCuAtlzLdswEarnFcnSOKK5TgXtQpoEpLySgRBqlysoE+tale3iNFZ
	3aOWB2dKIiNgeI/A84FIQahmUel/w==
X-Received: by 2002:a05:600c:3593:b0:49c:e3ad:41d3 with SMTP id 5b1f17b1804b1-49e7a5edc17mr76536725e9.0.1789467979378;
        Tue, 15 Sep 2026 03:26:19 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33e020sm35176780f8f.18.2026.09.15.03.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:26:18 -0700 (PDT)
Message-ID: <aa5eba0c-b9ea-4b7f-a529-54980081e259@blackwall.org>
Date: Tue, 15 Sep 2026 13:26:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, tobias@waldekranz.com,
 bridge@lists.linux.dev
References: <20260911105021.1385934-1-razor@blackwall.org>
 <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
 <b696c600-4ab1-41d5-b391-3f6373200cd8@blackwall.org>
In-Reply-To: <b696c600-4ab1-41d5-b391-3f6373200cd8@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2026 13:25, Nikolay Aleksandrov wrote:
> On 15/09/2026 13:23, Paolo Abeni wrote:
>> On 9/11/26 12:50 PM, Nikolay Aleksandrov wrote:
>>> This is a follow-up of one of sashiko's pre-existing bug reports.
>>> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
>>> while holding rcu_read_lock() which invokes the blocking switchdev
>>> notifier chain and may sleep. Nonzero MSTI changes come from netlink
>>> with rtnl held. Move the switchdev call before entering the rcu section and
>>> assert that rtnl is held.
>>>
>>> The call cannot be deferred because netlink needs its error and extack.
>>> Also DSA reads the old bridge MST state during the callback and checks it.
>>> A deferred callback will be late and will see the updated state.
>>>
>>> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
>>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Clashiko noted that the fixes tag looks inaccurate, should be:
>>
>> Fixes: 3a7c1661ae1383 ("net: bridge: mst: fix vlan use-after-free")
>>
>> do you agree? I can fix the tag while applying the patch no need to repost.
>>
>> /P
>>
> 
> Yeah, I agree. As Ido also noted, that is the correct commit id but it is
> from the same set. :)

err, I meant same release

> Thank you for taking care of this.

