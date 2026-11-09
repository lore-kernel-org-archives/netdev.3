Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258805;
	b=VMOvKH7Nlzo6BULnV2sa2DknufOmOFNFGEz2IlGcikkTVNlyzdHJ3rs6XDJnPGMgw/KE
	 41EYXOaWlSO4VaUTTZ1NJDhhOZdW3L31AN0IFdxJUZyJDv6jgpImLwNkLqnQsRmhuSQVp
	 QT0SSyJvqAKfZsYDnAVk5ZjfXp7Mh+Wvr2SGINVY93f61cisBc54GlJjwf+L6IvVsaq70
	 mLRHwGq3OYeiLAIVOic8f21kp+BlXNZoD7kd+1MjYHgm1pVzYE47bdp6lZC8yaBC0BMhW
	 IaKFDxID1i5DerTl0JK2jDCiIoEeQxLOKh3vp8ka8YAcpnOZORJek5ep2tGRaOM7T0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5ZNPQys28VTRtmsp1eXTTI33dx/ut9Rp+BrA0JVtHoQ=;
	b=A8rPjPgFZG/vyhSNIPFWRaN4ilcYOf2HNpz9Ixev43HM5BtOPDJJk5SFgX9AShaJDzSG
	 tQQppd6dBk1p6lTJKwgNfECL97/l4+zAtEeqTYjBwXqCmcJhA24JoALumJPMio24AM7P+
	 ozpTrEuGWlr/sONz/vjBN5/syKJXxuFTQDrgwoLfZLlbyz79f+2h7j9sQS7xfABE4MOJ6
	 Hkh3smV3mQDApCq8HPmczB1FnXcB4YVSH9w1sycxHYZD/K8KJCE1M99xrowY9Y359Oqx5
	 IAKkqJjFk4Qfo7uTDQZrc3DmwAZOlkI+c8wgrMDtZFRxSL++4Di3Ca1IEOXvtv29rgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENqfNuuA;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8E606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01D8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENqfNuuA
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2277173eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794258804; x=1794863604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZNPQys28VTRtmsp1eXTTI33dx/ut9Rp+BrA0JVtHoQ=;
        b=ENqfNuuAFxyDL2IDpZPlk/BWUNs84NuuaWn4CO+fnEOfULkSa8HbTJ4U+kZwlqlZ3C
         wXY+JQ6xnUn4dYwEHrWpxzbXVd231h1DooLE27d0RTcwHx95glBTJSNtdhHinDKbZl9o
         +6ul5n/BABoey2/7NoIYpdVeUvS5PEV2wm6nikcO4AJsBHiLk5vPtXo6cr9pWUMENIRJ
         WOlOTx1Uze0G3Rv1m4ykEJELQXJLBISMV3810gx+PUTE6Q2hsv3qcs5xKbUpj1b12Y+P
         NT/VgKXLG68HuF5ExMEpgF3fua0t2jPUMi2jnId3PXwjxP8erBbaMIVebdf0ClaIRRaO
         ttnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258804; x=1794863604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZNPQys28VTRtmsp1eXTTI33dx/ut9Rp+BrA0JVtHoQ=;
        b=NppWpNh4ADBTmmXQ4DnIs14qmVzkZxIP5P8h1ld6y0mTWjk1J1BLoSb8I7NFnVoR6s
         jhAl0dGQhfCIpTt9qIInwSJhXxlY0M5J4/aFYSKFwWJ/ppbXyDXiTRI8Nu+M9x+oCP6B
         TSlOKvJLwosHvd+uHEgXK30lgw1OE/kqlo7FGvfIn3CNIyzxzR018BpcsCgNgKOPWvak
         fvIYzflXQA+20aVEJ0fhZAPiXDLCeOd1fLwdgwPyMgBhTHS8I7igLuZ+16ooIh/AUJki
         O9q232My3FlemszC6VPFlR7h0q7ZSzuMbQRtl1z2I5w736SBEJB6/NYIIbsx7LKnTD0T
         81hg==
X-Forwarded-Encrypted: i=1; AL+hErFjgo734WzMVhTRLFuTl2Xu0CemGiif00WY5PLha/8ckfSO8c4YFBeHb6h2YJ55bj31ac1+8LA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Oqonf9azhs15mOitkGl3nWe7RlgaMTXWso2Wzy/Lb4POAziw4
	/J5eS4GgRARzgb4FYVReJV07p5Zy0xSSa/7Bvg4VKax2SriqmAcn2crL
X-Gm-Gg: AYBFou0VCR20i2Tk9UVwNwqnKq9OFlypkt6dGfGVEEQY0/G7GhlJNseaBv0oGeebILj
	/54KtpJ5+Oj7ML24sfCkJC32Pewt8IzS/JujOyn79QggYLp/fQ3MQWlStNTPyu7ebzKR5M219Xg
	sm/FvcoSZJm9AQ+S/BA6F8FBzkn6zebJ2nwso4XiMAs2S/gOO38glyqYowMtu16sMbkOJnKvIWW
	BdcQcm9aa9KgtarapOGquNsG+nB2uHrkEnD76Yr/TCk5iSw5/aDbUghA47gJtfXgMuCSodAtkgA
	8+hCfHlZnVr//XpOlXYGwy6v1qm3CqHrqxg3iKn8mUZMQZEk2ED7H0p0Zz5T6BseA1rIRFPkA9M
	SYessPMAJI1sjzT6wFG9aiuc3aicQnrHzYyt0ZrBmej/9uiA26EVA5PZCZUL9WVZiMumvDkCTMl
	GRJIt+B3SC6s8ut3CSHFgzs410A8MybkqH9c/yc9/QV4af8g1H4TTKgMF1PmkoAi2Oi+JjHPS6B
	Xpo0X+pADrf/QDYSlytkzgPK7xOIdYijWPt+ESSklNsaN7u7ARj2H193IRImeZy2FDxzod6QCLB
	/zGEsgQq8S10MHtcMG9S97mcYHeYErLplHWnbihSNFPw4rZSbk/E/Rbe8g9c+JqHlT0+TpfX7xA
	fYKQ0s/bwlGf6lUU=
X-Received: by 2002:a05:7301:6788:b0:36f:83e7:fb7b with SMTP id 5a478bee46e88-375202187famr859550eec.40.1794258803833;
        Mon, 09 Nov 2026 13:13:23 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::5:5de1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm931984eec.24.2026.11.09.13.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:13:23 -0800 (PST)
Message-ID: <754d48b0-943c-471e-9e10-f8f23d35994d@gmail.com>
Date: Mon, 9 Nov 2026 13:13:22 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: hds: restore HDS
 settings in ioctl_set_xdp
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261106031208.465456-4-dimitri.daskalakis1@gmail.com>
 <179424805404.994134.17832090759573772957@kernel.org>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <179424805404.994134.17832090759573772957@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/9/26 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The fix is incomplete: two sibling tests in
>   tools/testing/selftests/drivers/net/hds.py still change tcp-data-split…
> - [Low] The patch has no Fixes: tag.
> 
> --
> 
> selftests: drv-net: hds: restore HDS settings in ioctl_set_xdp
> 
> This patch makes ioctl_set_xdp() in the drv-net hds.py selftest call
> _defer_reset_hds() before it sets tcp-data-split to "unknown". The
> original HDS configuration is then restored when the test finishes, the
> same way set_xdp() already does it.
> 
>> diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
>> index 7f052c3196039..a1ea195743b56 100755
>> --- a/tools/testing/selftests/drivers/net/hds.py
>> +++ b/tools/testing/selftests/drivers/net/hds.py
>> @@ -254,6 +254,7 @@ def ioctl_set_xdp(cfg, netnl) -> None:
>>      """
>>      mode = _get_hds_mode(cfg, netnl)
>>      if mode == 'enabled':
>> +        _defer_reset_hds(cfg, netnl)
>>          netnl.rings_set({'header': {'dev-index': cfg.ifindex},
>>                           'tcp-data-split': 'unknown'})
> 
> [Severity: Medium]
> Is this fix complete? Two sibling tests in hds.py still change
> tcp-data-split, and they defer only a fixed reset to "unknown" instead of
> going through _defer_reset_hds():
> 
> tools/testing/selftests/drivers/net/hds.py:enabled_set_xdp() {
>     ...
>     netnl.rings_set({'header': {'dev-index': cfg.ifindex},
>                      'tcp-data-split': 'enabled'})
> 
>     defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
>                             'tcp-data-split': 'unknown'})
>     ...
> }
> 
> ioctl_enabled_set_xdp() uses the same pattern.
> 
> When "unknown" does not bring back the saved value, _hds_reset() falls
> back to setting that value explicitly:
> 
>         if cur.get('tcp-data-split') == rings['tcp-data-split']:
>             del arg['tcp-data-split']
>         else:
>             # Try the explicit setting
>             arg['tcp-data-split'] = rings['tcp-data-split']
> 
> The fixed resets have no such fallback. If the operator set "enabled" or
> "disabled" explicitly, and the driver reports a different value under
> "unknown", that setting is lost.
> 
> Here is the test order in main():
> 
>                   set_xdp,
>                   enabled_set_xdp,
>                   ioctl,
>                   ioctl_set_xdp,
>                   ioctl_enabled_set_xdp],
> 
> In a default full run, enabled_set_xdp() has already left the device at
> "unknown" before ioctl_set_xdp() starts. The new _defer_reset_hds() call
> therefore only saves that already-reset state. ioctl_enabled_set_xdp()
> runs last and leaves the device at "unknown" again.
> 
> Doesn't that mean this change only has a visible effect when
> ioctl_set_xdp is run by itself with -t?
> 
> The previous patch in this series, "selftests: drv-net: hds: perturb
> settings via ioctl in ioctl_enabled_set_xdp", edited
> ioctl_enabled_set_xdp() but kept its fixed "unknown" reset.
> 
> Could enabled_set_xdp() and ioctl_enabled_set_xdp() also call
> _defer_reset_hds(cfg, netnl) before they set 'enabled'?
> 

It's true that there is no visible effect unless the test is run standalone
or with a non-default config, but the point of the patch was to bring this
in line with set_xdp().

I'd leave the fixed "unknown" resets as is. _defer_reset_hds() handles some
additional scenarios, but as in my reply on patch 1, netlink reports state
rather than config, so no reset can cover all cases.

> [Severity: Low]
> Should this patch carry a Fixes: tag? Commit ee3ae27721fb
> ("selftests: drv-net: hds: restore hds settings") added _defer_reset_hds()
> to set_xdp() and the set_hds_* tests, but not to ioctl_set_xdp().
> Something like:
> 
> Fixes: ee3ae27721fb ("selftests: drv-net: hds: restore hds settings")
> 
> The test itself was added by 29b036be1b0b ("selftests: drv-net: test XDP,
> HDS auto and the ioctl path"), which would also be a reasonable target.
> 

This change is not critical enough for a Fixes tag.
