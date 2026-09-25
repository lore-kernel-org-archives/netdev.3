Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4D4854F8
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377920; cv=none; b=MmZYM4f1rXRTR5jQ4yS/3DYIuBFSsnxZ3SCJfqwFyR4NvQNFSKYuNEumdSJVW5448ScVDEAObHeJUEaiHbHfJkhgn1quoJ0OEbkwKBEZEJvhdRnbCEXEpkwUTasG1SSGuiuBh3HMtvgm+5RDoDP6w1y+cD5nZrP5EFqi3JFLTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377920; c=relaxed/simple;
	bh=HlSqHjuC92qxOUv16bU9Umy8f8TFh7MAVrq0Q/itHZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCoaXQfBIliGsCI824iMAGdJ4edFvP9o5Ei4zrXGWR85H+3MvvREXqu5W+sebfUwfjSD+kyxox4HHub/FP670rMN6ZfmzvTwa6nt5E+hjYSNKfj9T43xTX42X4wFFDw3esSe1NDDs1rUORdi5ai+S8DpPyJg6V3tfNOfTaV/xl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qni5EYZo; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qni5EYZo"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8e7106948so1146278e87.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790377917; x=1790982717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlSqHjuC92qxOUv16bU9Umy8f8TFh7MAVrq0Q/itHZs=;
        b=qni5EYZoVYQJSJQuMaU7kEc5cG6Unq9tFxB6lgEmnP6SLgzGNlz3rJAj1ytBa3kYB8
         tYdG5kJMIT++zv06tiywpjghgkVICylb0RjAorxn+6Xgq7rV3BXg2phErkka/lj/ZYmS
         y3cQ6toU9nK8KOgievflFRx2bFx/r458yk/+Lj8yybR2kbtq7q7M0cuE4fvNqw60CVQB
         m4pFtPefHGrC/JiskVGostkHUnkAw8sJrLMDA6iLeVjpkyvkLuIyPq7l6jJoEz03RSsX
         itnk2quMW2H2bEkAP4Ont+3JJiV5luIUlo6j3uEfBuC53Mkp/WbzL6PxgrZnMsUBC23V
         qizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377917; x=1790982717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HlSqHjuC92qxOUv16bU9Umy8f8TFh7MAVrq0Q/itHZs=;
        b=TMBX2kr1VTGJQLqR8UtY1HPKTh0ji6DVq1vp98G6QHYV1agz332ywq+dJ3ZGljSsVW
         6QNL9BiNY/QNcXAC5SWF2svQzn9USR7aqlQqZCDNNM2UEolvFp5g4h82FmiHFnRdOIWf
         NfwvU8DRrIQt/Pm3pPJe+hjuGPFPabaLzWSzYE+ZNfJY5Ct0yRpe8P+82H1nfmfpq46P
         R/LOhhxu0Znt9OLPVJscn5LZzZMyxRSgOIX11PrMFAOmvBrSfe4+hQp2reGzDohCRtmR
         5K46dOq4ggkfAUMGpCudxZEeU9ibZakJbH4jIam8Ah2GINmppxR/tHtk3gtvsH3JQ2Iq
         9RlA==
X-Gm-Message-State: AFuF++ksk56PAxvHXRbwAx0jDIfKAxah2UVz+aUdc8F/kU7aNuQ/Sgm5
	yrvu+yLsGJYDSs3YmXXIssip5G/7PVR5xVnwQay3fLNXjrfXtb4/+XvQ
X-Gm-Gg: AYBFou39iooIuGsB2rSdQeERpQuMNAxJqNQa4oD4Gn+gp/NqF8LA7L3iXje7zVoUlzG
	NEW9f4BrRA+Ki9cAZF6UqQmDmU0XkAWIzfk/XUtlwf7s15Lt1ricC8cpgh+BJb1uUIgQ2+s8mBW
	XI7kv8ey4aYOL8bFEXBuVXzJnmjVzw2wox17WnE+FMMbuN78b5FXLEzBxnUBkEYhLCM8A7xmUJw
	wLHEMM3yUYGgUU0ZhBji/u9gsjVaSzb7jhnBlr94V+iS9JvkYJv2qdYstIdVQoeuL+v4Z8rYuBN
	LUTAi02n881+YmNLbzQOt4zLyZLqZMe+a+Myp12tfVjzyNPHQEj6az8UmYmpXQLm83VoOQK7i3s
	oB9tB7kJNY5TdzdY2ZV46rAcfiyCkyE/MNq2zht1zWTFeE47Jy1e2HOtdBV6oAz0lGt+eIbIn8q
	ZjGnekPdVpI7h+Sp8mFZs4+0waCO5p6Vr0DjOVZhIHw0uFKD4SusGf4CLYRpdyAurUAI8ME2h0n
	rGkWAaDsVPAdN1N5gYF+CfLkw3AETB7DNK9w1zRuA==
X-Received: by 2002:a05:6512:2243:b0:5b7:6686:45a9 with SMTP id 2adb3069b0e04-5b8e6dcb888mr1135532e87.37.1790377916945;
        Fri, 25 Sep 2026 16:11:56 -0700 (PDT)
Received: from dau-home-pc.. ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6b01cafsm866819e87.55.2026.09.25.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:11:56 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] tunnels: add core and gre drop reasons
Date: Sat, 26 Sep 2026 02:11:49 +0300
Message-ID: <20260925231151.542109-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923141923.GA2841095@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com> <20260923141923.GA2841095@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 05:19:23PM +0300, Ido Schimmel wrote:
> On Wed, Sep 23, 2026 at 01:14:57AM +0300, Anton Danilov wrote:
> > This series covers the generic paths shared by ipip, sit, gre and their
> > IPv6 counterparts, plus the GRE specific code, in both directions.
> > A later series will do the same for geneve, bareudp, fou and the
> > remaining IP in IP drivers.
>
> Please only annotate drivers that you are familiar with, using and can
> test. Otherwise it's a burden on the reviewer and potentially useless
> code churn that will make it harder to backport future fixes.

Understood. I will drop that sentence from the cover letter.

> GRE_CSUM looks fine as I'm not aware of other tunnels that have a
> dedicated checksum, but GRE_INVALID_HDR and GRE_TUNNEL_NOT_FOUND should
> be renamed to something more generic (e.g., TUNNEL_INVALID_HDR and
> TUNNEL_NOT_FOUND) so that they could be reused across drivers and
> replace the existing VXLAN ones. Note that you don't need the drop
> reason to encode the tunnel name in order to know which tunnel driver
> dropped the packet.

OK. In v5 a new patch will rename VXLAN_INVALID_HDR and
VXLAN_VNI_NOT_FOUND to TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND, the way
VXLAN_NO_REMOTE became NO_TX_TARGET, and the GRE patches will use the
new names. To keep the naming consistent, I will also rename the TNL_*
reasons this series adds to TUNNEL_*.

> > Patch 4 adds __iptunnel_pull_header_reason(), because
> > __iptunnel_pull_header() reports a packet too short to pull as -ENOMEM,
> > the same as an allocation failure, and ip6_gre calls it for every GRE
> > packet, before the tunnel lookup.
>
> The series is inconsistent about this and returns different reasons
> (HDR_TRUNC / PKT_TOO_SMALL) for the same condition. I suggest that you
> convert pskb_may_pull() to pskb_may_pull_reason() and return its reason
> instead of HDR_TRUNC.

Will do. The WCCP check in gre_parse_header() uses skb_header_pointer(),
which only fails on a short packet, so it will return PKT_TOO_SMALL.

Thanks for the review!

