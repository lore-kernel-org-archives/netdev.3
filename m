Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E263F7A9F
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653392; cv=none; b=onaj61qTyRnqfYiGYW2VfqnbD67qsoGofDRWJyZpMxo3Wv45RhFetkunbJY7bTEaG/wGu8jTns4ov79MdnaKSlFXdaMtg5L9rR+6K7p8Xq6Q3uHMwGkwfIsvJgE3uaMuMSy2anO/TOwnzWTpFLBz04wqpEcVCSMt+q5wgxOaU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653392; c=relaxed/simple;
	bh=lqMXD3suOr+sitndCEj6l9BWxP7uFteuQLonBXuJZuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ub2PcvSj28TiUjP9uG5QhckUzEy91w86Lw1eWzb3Sa9pd0eybKD1+m7F0lu1UVpUmBtr8PCAMthhmyfo0ke6MbHX1CRQq0u/WprZYnNL0tWUlLpTXeVHWbdyrOyyd6me4CdY8RU8IcK0zwux1gqf5jaBHKgThS8X15u3cqSc9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Df/oG2tj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Df/oG2tj"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c20e70a0962so693129366b.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787653388; x=1788258188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4FFQMfXNiGpn+c0Ds6FNCWxiddPqnNk/uHSviV3ZIQ=;
        b=Df/oG2tjxtynxlxuivyAAtjvRVH31qMGGeAuXoTG47ewNzfIzWt14mc3N/Z4MpTVqP
         9E2lwuLe9H9xw+fQomqc6GzjvtORRHl55oitVz6UAL4ixQvmVgt+u3JdHglM0WpJ65DJ
         dhZSy7vwvRwihQH5o42oN5PYQo7DGYrp/XuzXSz5uyb6EBd/q+uzQwvUKxgbPreH7Q1S
         SADj7UtJ+rXFcS9IiWAM9JRr1X1ZdTLyk5XE3bOB75TrW6+7g20dZRdhJ6cVmh0bYfHE
         tBvOFnvNAd6Cu5+zrR5QbgzfSaUI83v0Np41maB/z6m1pN9bdjOWjBchPAc6nF6RynF9
         tzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653388; x=1788258188;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4FFQMfXNiGpn+c0Ds6FNCWxiddPqnNk/uHSviV3ZIQ=;
        b=ST3lU6vGmlicgs8gNxHmcXGKvtHtvBwC5QblKi+W32eEQCQP/LgBvPV8AnmA2B4TcC
         oJuGT/F43M87YLtexiGyUroNgkZzcsbBQ+aX2UHMcd28G0nV58Q2FsOBkokVfHCXfN2S
         OZ9hkIVSOnxVt+OcZ1dwrLc3dXrjp5sW5rthqVDW/8L2QxhCBU0P1KDbmPyRqphA0HOM
         mOOn2phY0j7ofUunPHDO3wo7c0O9b3EMEupMCW80MiszlquUmYXAAnL3RLt15WNUtCpo
         exvEk6AbN9HH0lokPLxShrSQwOeSohOG9deBI2ynvtiJJ3EsOHZkhZmUT/2UAz0fnqd6
         ZmZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0BZIkHA8AGNvB2DSgvNXzCLKBpLBanXV79Riq5we0au20awz8uY2qPvIUfnQTnRv2gKybzio=@vger.kernel.org
X-Gm-Message-State: AFuF++l00atuFLgSuFsM4X62eoqDPVYsC6aYtsUZ9PxTJalavhl+l5n7
	rhm5jLi58wlNFF2T8hoz9cHMZ07AQP3qfsdaHTZZ65Agb25t210PMznnTI2FPk2ELgE=
X-Gm-Gg: AR+sD10whAffLaoAwFj0dldsXK1qC5ANaD7g3ysCOwHozxKYLBdbmCvcyxBTEltgTtv
	6wxZTJRitobMSh/HMj0kgfq4ho1qGrRiD6/1Xlb2RyLe0C8Dy/hV+OVwAcUs8vJjb6EFnhieLco
	NoxQwrqaHSf09zaOaQb08D6Gc/8AwcAwkUzBsA+0XYxDLwfZYIOMBKn396k9ZV0635vxLtsTXxW
	dcVWJxoxHmBZ144SOn7P+TMG3BREC0cgEP8/H38ezYp1BVWXfutHUtzjlGEms/GuckgyYcQkzXR
	sYYRllRFo0j4a9IXBX1Y242sla3HK0BabVoHcevCt8WL21oRlAiH4jznsJLzP85jcVhHzXqWUxD
	lCOw+RkT7rhB6rAmxd+7D9E9zQaX9inIuCuU0IQaoPe2AS0Ywi2l3rvu7/u4vvFSdwg5Z+AAbAT
	IWk3hy2eDFhFI4dqtr2f4z+KXgNNM/2+5dMmznMhcPVm0JmsG2NN50+PjdyirGousKnPpLFMSlP
	3/kJLubD/fNdQJi2no=
X-Received: by 2002:a17:906:fd81:b0:c21:35d0:f43d with SMTP id a640c23a62f3a-c246a6c52c2mr3630062566b.16.1787653388035;
        Tue, 25 Aug 2026 03:23:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1880346766b.8.2026.08.25.03.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:23:07 -0700 (PDT)
Message-ID: <f2d97d29-e380-4d1b-ae21-f5ea406119c9@blackwall.org>
Date: Tue, 25 Aug 2026 13:23:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812113435.1854275-1-junvyyang@tencent.com>
 <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
 <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
 <20260825101954.3799675-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260825101954.3799675-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2026 13:19, Jun Yang wrote:
> On 12/08/2026 15:21, Nikolay Aleksandrov wrote:
>>> +	/* use _rcu to preserve the next pointer because it might be in use */
>>> +	hlist_del_init_rcu(&pg->mglist);
>> Just to be clear - I'd expand the comment to include why it is safe to do
>> so and under what conditions (multicast_lock held)
> 
> Thanks Nik, that is much nicer than the restart/checks dance.
> hlist_del_init_rcu() works - the UAF splat is gone (7.2 + KASAN).
> 
> Before I spin anything: would you like me to send a v2 with your suggestion,
> or will you fold it into the open-coded-list cleanup you mentioned? It is a
> UAF with a Fixes/stable tag, so a minimal v2 now may be the easier backport,
> but I am happy to leave it to your series.
> 
> If you do want the v2, here is the expanded comment I would use:
> 
> 	/* Keep ->next (held under multicast_lock, freed later by the GC work):
> 	 * a port->mglist teardown walk may have latched this node as its next,
> 	 * and deleting other groups of the same port must not truncate it.
> 	 */
> 
> Thanks,
> Jun

Please send v2, I don't know when I'll have time to prepare my changes.
The comment sounds good to me.

Thanks!
