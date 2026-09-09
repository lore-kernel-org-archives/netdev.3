Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A25803AC
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966202; cv=none; b=DD0a8lajDY8TStyFsTQldToQfLxxc9soA6ZCNG9rC9o/Y1pmw+vBuJTDJLKBkiS0U8xJHTa4WQyX/lN2/tB8IhWajx3L++btAFTeXCYgTSofsg0FJDt+SW9RN8CAbugpot0V/+M36JWXMysYJNH/VYWD72IShjW/40PBoMf3inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966202; c=relaxed/simple;
	bh=BBJ4wLEPrUADpaj7m+kclRs22KyvWtJ+vsNVIad9Kns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAnQSgmOy7EhpLwB0+RHNXrCv4i2wj4WP3+yJMmDNmZrdF62zQy/xbih7fsnsGrIrmXiuhZ8y9IVhH8lSLiMXCl+h/RJdbkIzU2JVJZb7PbgkW40L2mCLsFqZA6sN2EqmgGBrfaWipf/smGgI33M7iaNbIGuLjbVQQcjEpln6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so1730088f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966198; x=1789570998;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDu/JSW7c/FW0MavWKYRbPoLSOFM4MJHY7ZmsuVCp74=;
        b=NCGI3uran26lSTaz51HFYNaDQ1tAe+W6LFKD9L9TnF6qlbe51pqxYByJN6x5pbAu38
         +/M07W17640X4NHEHsfB5Qy6kVg9sEgUYZ1zUjsG50dGaHd2NS0wYGWUglKf6vb8U1zu
         cqdU09jWKkx7mbmjGyZyTKuiBFpPACY9zrgC+lBLej2BGp5aYZRQg+qTQCJASu9UUVLl
         P8oLQo/tBjI7fk/MDVyTEeI13ewNqbqarmYRxOdPZRtDwCAK+l4LRl5UQ9g/I0Df7NFb
         XGlD3XTpsD2NDVIa1xYYsTpESmTUiO+SbJq7LjxVl9QUX8buP0rAbFQAw6EO9W23fALL
         aV0w==
X-Forwarded-Encrypted: i=1; AKwUvBy/LxPvA1fmGxzj6R21fgqq8g+ofdN4Ee6V5+KY4oAGgYpHFUEskpH8FCOfI9wNe9j3EcNyyYA=@vger.kernel.org
X-Gm-Message-State: AFuF++kZuyyTQlYzpERL0N5JoDiPH1qk7l6MvPbA8VAY4sFe8YeWQ3FA
	jC4NSmFfUCaqY0nPGvBQj6bZ4h77ld74mohvaAu2p28a3iXZ9uDg0fha
X-Gm-Gg: AYBFou1QYC7BFskq7luh2jsHjilAxVg+GSz9XuA4D8WS6t9M746IKdI/9rIqur6NkW3
	FGbwflR2gPTVPze3GJlgiN0r7so9MCeH/h5gjUu8xeulhpzd+k0OdH9+Gzt8smMYDCfCbjpGQVV
	/qRGMNoU2mUQLl9/VeBz9s2QaN+US6evNbEickK1P/jZcxpEiCLAZwSq+etMg7/uax5uuQRgxdb
	n8wqM+hJEQJtSB+f2fL1pf/U1Fh8QNF2kEfb824FUblDBOP9ixlSGKG2SikZapZY98vcIragY9F
	k0uZMlt2NMbuU9tbNkpqehe2ZQOhLGerATKFQefCeI/a2fQmSEiJTNBtt8OT/SAxtx4k9jwQXqo
	tbKEb57J0isaeNunvAF0oRWhQ7rLN1W6afsZ3OSRQY1wFKkFmA9wB5LhpM/Qk9tp3DUkR8Lj0ab
	CqDPYuUKApZy11uRipj16xQq0qUAL988YxV5pZoOosp32Vtuybar01pok0KQqH/IFN4/KNDOcWz
	Iab+vXnvGUucLGHvXKYvJeOGobD0VESR3pG
X-Received: by 2002:a05:6000:4020:b0:485:8f37:79b7 with SMTP id ffacd0b85a97d-485c23d66camr2033481f8f.33.1788966198129;
        Wed, 09 Sep 2026 08:03:18 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm46572091f8f.4.2026.09.09.08.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:03:17 -0700 (PDT)
Message-ID: <34457ca4-73dc-45ff-90f7-f3fe3c62f2f2@ovn.org>
Date: Wed, 9 Sep 2026 17:03:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/2] selftests/net/openvswitch: SCTP tests
To: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 i.maximets@ovn.org
References: <20260909122521.2687193-1-houminxi@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260909122521.2687193-1-houminxi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 2:25 PM, Minxi Hou wrote:
> This series extends the Open vSwitch SCTP selftests: patch 1 adds the
> IPv6 flow-key test (mirroring the merged IPv4 test), and patch 2 adds an
> SCTP NAT test exercising port translation across conntrack.
> 
> v3 -> v4:
> - test_sctp_connect_v6 now also asserts that installing a keyless
>   ipv6(proto=132) flow is refused with EINVAL, pinning the reject side
>   of the match_validate() sctp() key requirement (pointed out in
>   review: only the accept side was exercised, so a regression dropping
>   the requirement would have passed unnoticed). The refusal is checked
>   to be errno 22 specifically, not a flow-string parse error.
> - Wrap a few over-80-column lines in the NAT test; checkpatch strict
>   is now clean for the series.
> - Rebased onto 548b86839f7f.
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> 
> Minxi Hou (2):
>   selftests/net/openvswitch: add SCTP flow key test over IPv6
>   selftests/net/openvswitch: add SCTP NAT test with port translation
> 
>  .../testing/selftests/net/openvswitch/config  |   1 +
>  .../selftests/net/openvswitch/openvswitch.sh  | 201 ++++++++++++++++++
>  2 files changed, 202 insertions(+)
Beside the Aaron's comment on v3, please, avoid re-naming patches and
the series while sending new versions.  This confuses both the automation
and humans trying to follow the history of the change.

Also, keep the full changelog from previous versions, and include links
to lore for the previous versions.

BTW, it seems like due to a volume of patches and the speed you're
re-sending them over and over, email providers started to reject your
submissions again due to spam detection.  For example, while I'm on
CC list for this patch set, it didn't reach my inbox so far.  So, once
again, please, try not to have too many patches on the list at the same
time and try to avoid re-spinning them too often.

Best regards, Ilya Maximets.
