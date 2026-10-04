Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED7391505
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121486; cv=none; b=b6TFEcHD28nwwbGbtfNSkZ6EG3HBOuU/DnzEIQwb/1Tu3uljUtCAQ3WHuGNLf6PZmxm1BK2uCANY4VKTUW3LeJ4LOWrp8kbZ1rxPQ2+/Si2aJ/cNktMkqOxsM4wRpmoRcr3ueV/yRC5RkJk2DZ8mLWcZ083HS6PguefKc+4yc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121486; c=relaxed/simple;
	bh=ln9flUKLuXflNGj9stfywtJ7V/181gsJo/hWYooAygk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7+04Vl9408oIEyPd0BeuVH1y/yJ5cPKaXPBLWev9qC6MdwIJI3S4ju2T59IOQcTX0IQ2n/Ni830TyqaQtgotlXsgn0UueVrCsLT+iqHUcsluL2jgS7gEKIQnoT33YMwA91fVM+gt0h3uJ5Ri9aHXwQVHMQIjtI+qAjLht1xGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lpo0j7u5; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lpo0j7u5"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so270132f8f.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791121482; x=1791726282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/AXmPQS6GE1nJ+OCjL7tvM9iqkO2JwhEp916Dgp8F+U=;
        b=lpo0j7u5tz2Xws2oCbBcox/1SvvG2cFO6KU95lzIWD5KnfaKercolp1DYFj7NjzUwZ
         ToFZLrZvHF7lvjbFYGMO9DBA4P8ACqd69wy6RkeaKQiCWq11v6L+r8WnQ1SNv59IGsPy
         LFZ5WBOCwB9aWXco/k5t6pPz26SmYaxQYEBDyILOb97MdTKNIi7vqrMdEb16sv9ILzmF
         N0m6EZYbnsuZ8ZP+4By6typog1L47eK61M+aezVDhlt7Zpi8cGDOBiApPOhtqw8Gcrge
         IIuuzPiPtefhKj805DUVyY9oW5/7ojfBIYgdtmnDIW5W8hxHJkRIpTIHvqd7fSz5TJ55
         UMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121482; x=1791726282;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AXmPQS6GE1nJ+OCjL7tvM9iqkO2JwhEp916Dgp8F+U=;
        b=eSbl9XQrs4D71TIvB4va3c9XRkXYGng25CjzHyO7GCGYQXBvRRMxJ4BGsl5uElCGoP
         dzMO96SzFreoVj79R+ufi1L6CYK4hfXOreU7W0OkcUzqyUo/ybGRmPF2Yw2R5pe4IAaS
         Gf5uiOXQYsKevmPumRRpJYJQyZcnOrRtzmybhMIjxITKVSRqpwiOA5wfAPrnGeaTk5wD
         rNYR2o4/bo9f8GSUYYfutplONvtLaV6ojngZacFuCS7koK+i8hyAyzGEaKYY6wiPo4zH
         RQ4n8GGmh/12sFag1EI3nkPIpxHUT9pHIkM38VlJcPIalG+vXJPTupgU9RN2PbIVNaig
         vj4w==
X-Forwarded-Encrypted: i=1; AKwUvBwIsOlcWmcaVlaYQ07J4ZR6q8SZ4I5t4CNuB2Xl24OI0aFywbB4gOzze8eu4A4sNEWn5SXVGVc=@vger.kernel.org
X-Gm-Message-State: AFuF++kgZEXjzuExRG8pofq8r5sDxpgxnN1iIKKijfKWHpmJspraqyXp
	4+Xl4R8zqcPSGtO3Bz7R0HWpN+w7UE4pagd2NOD7r7pt+tARi/PQp0sdMGTVzRN+Qg0IZ5Z7fiw
	mguhU
X-Gm-Gg: AYBFou3iP6nNr3bP5X4L+XS49gt3HVFgSyGmmVBpNW4dk00DJcOG1c8cIn55+gCzzKv
	bl6RCKdTt7X2Vg1JhwaqIBhT8lAyiRyrxQifoCmhJwTMRMc21uJxqutRtJH+d53xuDC4M8CMegM
	Ji4tYnXPUv+cj3Q/+jYROJq+FDtCR36Vi3ybWKNgZnrMziAuR/nvtLwk0iVrtkMhBUMypeaCGCL
	o6F26jBiwYqeEqdnpn1VfJIAaneGkDIBFi9HWtVUXuDg6oyRB/8cBV5lsJeKqMmfaCiQNUBXADQ
	5m96s+Otu6STfBz27id9IFKgUoJByzjIUTm5KuHHZjpop+MjpZnN5UrXJK8pQdyV6E6vQKGDdSB
	hzf2KaIu3hnVuNqaNPmHCiGL16Cw/NE+C2eEa+Nqt7mkWs5HTFPgXBlaGTe+8d+KApK5PSuxTuI
	AqVEggVm7BMNjws8PaU0YP1xdRzuY42pxqzrKEYWV7lGoxJKpv6LYjiDohLudmrtbFQhETKif1R
	Ax/asFIicihOyjpPStvOH5hF/RD
X-Received: by 2002:a05:600c:530e:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a027534c46mr151316115e9.6.1791121481987;
        Sun, 04 Oct 2026 06:44:41 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280be5dfsm287188975e9.7.2026.10.04.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 06:44:41 -0700 (PDT)
Message-ID: <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
Date: Sun, 4 Oct 2026 16:44:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Content-Language: en-US, bg
To: Julius Bairaktaris <julius@bairaktaris.de>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: Ido Schimmel <idosch@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
References: <20261004124254.3525496-1-julius@bairaktaris.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261004124254.3525496-1-julius@bairaktaris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2026 15:42, Julius Bairaktaris wrote:
> br_fdb_update() lets an entry roam to a new port without holding
> hash_lock. It notifies switchdev that the entry left the old port,
> writes the new port, then notifies the addition. When two CPUs receive
> the same source address on different ports, these steps interleave: a
> driver sees two deletions for one addition, or an addition for the port
> the other CPU wrote.
> 
> DSA counts references to a host address on the CPU port. The extra
> deletion fails and the extra addition is never released:
> 
>    qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2
> 
> With one address roaming between a DSA user port and a Wi-Fi AP port of
> the same bridge, the error appears 3-6 times per address when the two
> ports receive on different CPUs, and not at all when they share one CPU
> (4 runs each). With this change it does not appear (6 runs, different
> CPUs).
> 
> Take hash_lock when the entry roams or its flags change, and send both
> notifications under it. The common case, where the entry neither roams
> nor changes, stays lockless.
> 
> Fixes: 90dc8fd36078 ("net: bridge: notify switchdev of disappearance of old FDB entry upon migration")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> ---
> 
> Notes:
>      net-next 941056f91907 ("net: bridge: fdb: factor out existing entry updates")
>      moves this code into __fdb_update(); the same change applies there.
> 
>   net/bridge/br_fdb.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 

Absolutely not, this was made intentionally. Taking the hash_lock would further kill learning
and roaming scaling. Surely switchdev drivers must have dealt with this for some time
now, if you'd like to fix it do it so the software path isn't affected.

Cheers,
  Nik



