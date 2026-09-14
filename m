Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35934D4E9
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368871; cv=none; b=dAiVYJl3NxHNhSFUUHs/4VQD60DbOd93h74YdcJDz6lE7cRrKXjZsxNTtg69U//6Xgwr2BxJChgcQOrUw4b3hU+vCQyJ2I4nByb7g7/3L+2EZRT+FImAmG3Zy2MZITGy33bPxIzM8k3QxoGeZ88C3vNgQqSJ+HWWPccXVoy6xHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368871; c=relaxed/simple;
	bh=ly+vK1eV0MGOs1RGreYF74zbHkfsvtS15LwoHeCeR5w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ByOXK2L2NAkB52FeJ+Hljug1zOvkYb5FeScH1KwQEQJVaIObvwotVdwn6pbV1Zcd5WzgDU6QY0UiRSeC7RA7fAJzXTYtUfctp4nrxijjzyZqqxf54jlUujESnuEDPLlwBy1FQHX6TWniNUe9IHdSNDejLzERM912SPMh7XzBhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DaXHsQmq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DaXHsQmq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so770570f8f.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789368868; x=1789973668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eugk2zCKqcw2FGieDTlwJSn9meU/w6rFiEHk/2oTu8c=;
        b=DaXHsQmqTqg+TuaRqTofJkyotFMMc9zFKXY3nh4m0cy5/ICkd80tE6os2H9zk58mNK
         zbGvc2vqcDPp1uE/9zfyY6mfIEvbQy6VU487Uwxu7OHjj9PCZVZq8xFfllxaGHbt9KFt
         SnsLcsyI5C4Tl2NuUBS9yw0p++s8utkRfV6kVzLNDuNNl8OFbK3aSLfUUvtfbAZrTGh7
         LkGOQL17RhaLOhG2ems6znOsz6Eq2hFLd+QoF7NPh9WAgcLcmoXXdaO8RiXh1uDcx74x
         Dhwnx80MAfUQzesvROywLLjcd2oXa/tpb7UJIn0ilgDIMTpC5ez7G5H1wmmkrM/+o+am
         3Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789368868; x=1789973668;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eugk2zCKqcw2FGieDTlwJSn9meU/w6rFiEHk/2oTu8c=;
        b=s+TpvH5NWdrARtf6MnPzwn97Ash7wFbdaOQwx7/wPHtPjd6Xh037XVyk+M5He4gsbW
         MWGLXg7lLTG//IiFYs3IKEoAvl7T93bFdymlARSBN9IupHmqsQC4lJQG7aAxQS0nhb1m
         ecVhT+5FEprwAoshdjLqtARvnS1zfdlb2WikzIBdXC/ajuD/nZ1MV0Tj/MQcV4jF40cb
         OMrLz/eAoVGMSdduUV+jw/MJfoORSASjxk6heXnd7zG0lRG4xtGaOBtLt86cREIFk2t6
         e/p1LCYkaKx3UZffMWOd84BrsuKBJFfVjfdm+LvffqW5WgH8MPEkWiM2BSVkMJRtsuRk
         XPqg==
X-Gm-Message-State: AFuF++nB3rg1Xg/7U06rUs99fpL9SP9MNuv3IGXviJauPpTBZLPK/3Uj
	xHTl4UZXlWOZQJsPDGT57IJooJv6wf/8KbZqTVsXe7OhEeyF1wLdEvoRxCik223RxV2tBPnFH3c
	s95zrj/4=
X-Gm-Gg: AYBFou0X413zyru72SpQkMmgHfqUjhVPpJITWi4pTfUYVlSstDjGKh0Q6mqeEW8ZZRu
	wTVIWyNFm0Ucjvtfigl2v07MdWhNduOp91ngW2oXtpWXSYBaOiECatO3RU2PSIvlhbxbtHytmbz
	UfpoZKwESJ8R3ZToWDUnx/8szNuy5JMstObrPVRDcQhUs6oj764Vz4YfpiXg6iO1LNdzZ3XxC7S
	35zt2JDZ587iXcF2KuGd+1c4Pc4w1D5dMXx+lIK9SLTZcxI8bEC2OtUxjFP8VnTdj9X3djovtO0
	ACUB13aG24/i6aqC5uznvHASqiFbQvsnydZsq9+1XPYlZQbhUh7ezO6q54ogVQMHZKTkFFi4Xte
	emezdHOmc4beGdJTS28LXLZka8Ex8gTVJrHcsb8gxqdRfQJQ2iBL9aC56+0yck7o9iH8gFBipq8
	E9hGu0SvRIS6OpuEpR1y02JnCNvjP3qm7uCxirlr1MPID5jFGsmP2AtmPMw7IEydRN/Uqgu56AJ
	FDrzEmtBNA4NNmL+FGB85wHt9yOgg==
X-Received: by 2002:a05:600c:354a:b0:49c:ffe3:2b3f with SMTP id 5b1f17b1804b1-49e7a637667mr13448515e9.3.1789368866926;
        Sun, 13 Sep 2026 23:54:26 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm357607795e9.3.2026.09.13.23.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 23:54:26 -0700 (PDT)
Message-ID: <45f4c367-e9d4-46b0-9325-0182c936bc18@blackwall.org>
Date: Mon, 14 Sep 2026 09:54:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net 2/2] net: bridge: vlan: avoid NULL dereference on
 flush errors
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, petrm@mellanox.com,
 vladimir.oltean@nxp.com, bridge@lists.linux.dev
References: <20260911100645.1360386-1-razor@blackwall.org>
 <20260911100645.1360386-3-razor@blackwall.org>
Content-Language: en-US, bg
In-Reply-To: <20260911100645.1360386-3-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2026 13:06, Nikolay Aleksandrov wrote:
> __vlan_flush() is used for both port and bridge VLAN groups. The error
> path unconditionally dereferences the port argument even though
> br_vlan_flush() calls it with a NULL port. Any error (e.g. switchdev) while
> deleting a bridge VLAN can result in a NULL pointer dereference.
> Use a bridge-specific error message when called for the bridge device.
> 
> Fixes: 5454f5c28eca ("net: bridge: vlan: check for errors from __vlan_del in __vlan_flush")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_vlan.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 1748ea1fc202..3aa0e1fedeb2 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -467,10 +467,15 @@ static void __vlan_flush(const struct net_bridge *br,
>   		vid = vlan->vid;
>   		err = __vlan_del(vlan, true);
>   		if (err) {
> -			br_err(br,
> -			       "port %u(%s) failed to delete vlan %d: %pe\n",
> -			       (unsigned int) p->port_no, p->dev->name,
> -			       vid, ERR_PTR(err));
> +			if (p)
> +				br_err(br,
> +				       "port %u(%s) failed to delete vlan %d: %pe\n",
> +				       (unsigned int)p->port_no, p->dev->name,
> +				       vid, ERR_PTR(err));
> +			else
> +				br_err(br,
> +				       "failed to delete bridge vlan %d: %pe\n",
> +				       vid, ERR_PTR(err));
>   		}
>   	}
>   

Note that currently only switchdev can err out and on the br_vlan_flush() path that
is unlikely because all ports have already been removed. But that relies only on
the facts that no swdev driver will return an error at that time and that __vlan_del
returns an error only from swdev (currently), these are not hard contracts or APIs
anyone follows, it is by mere chance that we haven't hit it. It would be best to handle
the br/port cases separately as usual and check the port pointer before dereferencing.
I think this belongs with the previous fix for the memory leaks.

Cheers,
  Nik
