Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F729A309
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426793; cv=none; b=dj6XFQfVdjyOueuQHl98haxUFoX8/w64oNrU5/roq5EYYm8OmOgtvyyVNwCCrgmmE5Lrt50PQDwfdn3fzDshYN9N8traXzGzaOheWpAWPTpMB49NK90VKB/dq3RrZuhts5Qr/rqUA/QYwI6EZjYBteaPkfAC8wvHzGKWF2d6QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426793; c=relaxed/simple;
	bh=v7QarMzg5CgsO3LrVrBc6HHmZ1T8TEAOgxCzRC5ZhUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q262/qnY+/mdTaUpNQ0T1DYFOVv0mbIXBmHm4TokqsHeNu64V3z+lR09CtCujNRBhTvvNT7eDz9G1IDC7cDvl/3Hyr7fyW2k/L3/TqMdHYFjg3Zv1ka7XabxdlVG0TWWq/8nConi/c4nhMChNLG/DU19Qd9T0GVkDOul+mocykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6a18ef2253bso1559721a12.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787426790; x=1788031590;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4Bjb1GpTNcD0HiLW3aiRTU/I7DrDIjKtBzU12ZQxAc=;
        b=gm1FHzwSX2AchuAPEM+7dbv741ic3eCQ1JrGsc7Q5AP1uNBt/lpkbmHXfdVoTsNCPa
         RMVblvjFiiXVnig0mhTNQQP+WLNTwtVWamdmZpcbXncjPvqBzsvY4cuHKhoYks6QtakK
         lCG9p9XVSs3jMVyxip+rqyeNCMHOUsr088zfMlGEPsW7hvRJefPPYAt1HjwiOZFYiW8F
         Dy5LeGLNDkyfnufYKGrx+ljBuwcyHrZU4wev+jFPRGHxsTi1+AKWPP5oVQVchTnBsOtU
         hQ2xKJR7XShuBxSiyXx3c3Oa9oEkx2oT2I20YAq1SmpMitI943cGXW0/0muYgPjsNXx2
         oE5w==
X-Forwarded-Encrypted: i=1; AHgh+RpONpbxXyAqJRhfyBoJun5rdk1u8ClqVbn3jml8CL1fnj1+51PFS4dJN/pAicV46tIUwbkTsaY=@vger.kernel.org
X-Gm-Message-State: AFuF++nCSjqP8dPTig7SNANXHaggPY0uVCdAP9uL7Ueq4Ww6JCGee+D/
	921LRhetYnFV0w4E0dypGxs1eBnA0SK/gI6VnNVFvHR7HspcbONEp1/v
X-Gm-Gg: AR+sD10mAR2lZbfcpJZfFlsvMnWhxpvf6bmDaAet3E0hB3RrTHg3LRWJYe0StC3oesU
	dQAHkDgXAOkyc5jGbF/yOCvUAYs+RMFvI3/pKU4UOh5SjSfPXPXFkuPVD9A2XD1ifIdRbvdkFwu
	kyTju0CIOPBqT3NvMZp6gZ4pChKoZ9ixYGeFGwpXGFPMu+d3g0crhHP1Z8sTi4y8HARHYifC7RC
	eQY7Qm1oMH5JvygJzBUDXroqj7XmmMrR1055DTHIyycFvJONOvI3BoaSOHKeiix/JwKDSHxHwH6
	6u0D0iiAMj6p19AVFk1Kpw5CKNrNx2fW24AhgE5im56EtXuNOGfTSRZ2g43lkR3ejtSt7j9xUHv
	p+INFV7mpx4u8ZOQy6iDh35P1uNuUl+ThTv2/crpSKttk1CIP1NMtnvFsxSPsCabxzsRHWkzyF0
	nBcoYYxt9uv/T/JuFeW+3BxVO/NSXPneep4rNfC2S1cZxANM+758S/UClWU2RFdR4zcQl8uCk/q
	wuMA5Odw4wB4S5I
X-Received: by 2002:a05:6402:3547:b0:6a3:6b8f:94ce with SMTP id 4fb4d7f45d1cf-6a42f13c1a1mr16462339a12.3.1787426789612;
        Sat, 22 Aug 2026 12:26:29 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff17df84sm17871482a12.31.2026.08.22.12.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 12:26:29 -0700 (PDT)
Message-ID: <86c61c39-901e-489e-aec9-fafe639276e7@ovn.org>
Date: Sat, 22 Aug 2026 21:26:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
To: Jakub Kicinski <kuba@kernel.org>, Ilya Maximets <i.maximets@ovn.org>
Cc: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>, Willem de Bruijn <willemb@google.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
 <34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
 <20260821170950.3e278b1f@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260821170950.3e278b1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 2:09 AM, Jakub Kicinski wrote:
> On Fri, 21 Aug 2026 23:45:41 +0200 Ilya Maximets wrote:
>> Unfortunately, this needs a rebase now that a conflicting change
>> for skb_zerocopy() was merged:
> 
> Ugh, I was supposed to merge this first, wasn't I? Sorry.

Not a huge deal, I guess, the conflict is mechanical and the patches
are simple.  I can take care of manual backports once we get the
'failed to apply' emails.  Just a bit of busy work.

> I was hoping for Willem to TAL since skb_tx_error() is a tx ZC
> thing, now I realized that he wasn't CCed :S (please do so on v4)

FWIW, I CCed a few people on v1 to have a conversation about a proper
fix, but that wasn't fruitful.  So, if I were Norbert, I wouldn't
include them for the new versions either as doing so always feels like
me being annoying. :)

For now, the plan is to get v4 of these targeted fixes into net and
stable and then remove skb_tx_error() entirely once net-next is open,
as it seems to have lost all of its prior meaning.

Best regards, Ilya Maximets.
