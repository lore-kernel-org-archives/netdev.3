Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083371;
	b=H2oiLQU9wC8UkfQd5r9FkEYh4JBXiSXQ32bG7pviNSM351yvv4QCLHly5w0RB0iyyeSe
	 PMCwA5mapNCHgXIPD1hdcEZW8n3lN1+qez8CHPVuahEaMkS1CeEZ1l7NDj0iBqJMv9yGC
	 xKeITzJ5WK+mp47hWqSyiuGnOoYspAsPrS2AE8v5X0bC3hkWnsLJz4BThLs+rE+8hREji
	 knigft1oAFU3D1AitKIDpN2KYBhsqoQKpKc6URhJBRMQVENSyjrCjM8FOofGuE7D/dCFo
	 GXOuRJQ3SbudYyufev96r6NQ4BqV/feFtv2ZpNx/Izm+rdqf//9CbrEMijCrT9eMWLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083371;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pRiCUUjLhGU4QryeqhGvx/oq8Ldr8tbhEqJVg4ZBW9A=;
	b=X5k6eE8TJfVPuStuNAtAWUWbPFECyD5v2f1kYHgxQsSvnpA33DzMefbcJUD+1iI1Dupg
	 Q+YPq9ctzgP/Aq+Hsidh2hAMwJSeyOQ50mcudkj9HCMV681gFny6iycgjv/sLfL9D6O3W
	 3zzz+oeP6kBWqSGAWu1xJ2TvRnD93sIf4R7+iVuvhVESZ4jKzPp1mxESNRfJY5cDJUoeG
	 3j2CT+irYtL2dqWbZrOOibN17IqYvA0K/97SW4bEON52mcZk+YzCj1Q+zmAX2rOUHmE2o
	 snNLI2dLc7djKPqTwuIIFbGCWWRShTSz3xBoKFax4m8wU0FhNOCA2Q1UICrhjr69tyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcQd5Rgx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B1606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcQd5Rgx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B34F1F031E4
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793083370;
	bh=pRiCUUjLhGU4QryeqhGvx/oq8Ldr8tbhEqJVg4ZBW9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RcQd5Rgx2hQVnLWed84Onq61jdm8RewlmVFnETkOabWqsAIYlP3t6v4NDguMWicf4
	 XIoPv6Q/N2BjvVqNIdr0SJ4Q3tJrBxXi68L/8eqMPN8VxsDzTXBEyTU8ubCCCsPGAY
	 cNzztg1U8597P0XqYS9yQ72n9R4sE77DtrOwpuyGA2TEC1rjOR8Pp7Et4MSElyd3Yo
	 tGLt6gc98IH3gRI9dGsPCN0m2TxrII9PhM37Jmv7c8jshDscyh2A2II6jxlrQTgG8k
	 8AYM3VgfN69mc04S0LIOcwWoYgPM8M20Ej+ABvrkFormUoOgBdW3LhTe4V7jY1wlgD
	 FRQ4Oro1Oi57g==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-48e94879f02so1149885fac.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:42:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy5GZO21dR5oHdJIBHuKgHAfVBSCFKeiPsk538G5u/UG0U/8wBQTDfjvO3Lu/tSg3AFp8ZavNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgwKn82tgzLfHKR2QR9AnI+rfr2mquB1Tran94+UMsLJEG7Opq
	ASiPchjDT8sSu4/u0h4NVN91Jre5Alk8Ej7I0Jly0nXTlYGWHzy9YENCYOD0NolScuCrnhQyHRY
	1EU3J5eaauLWGJwNR3Q+7RneBBQWe9lY=
X-Received: by 2002:a05:6870:c22b:b0:48f:e25e:e202 with SMTP id
 586e51a60fabf-4a83f5b8983mr5062981fac.61.1793083369809; Mon, 26 Oct 2026
 23:42:49 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026091549.605810-1-p@1g4.org> <20261026091549.605810-2-p@1g4.org>
In-Reply-To: <20261026091549.605810-2-p@1g4.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 07:42:39 +0100
X-Gmail-Original-Message-ID: <CAL4WiioPvWBTb7uq2ny=AApqoDst6fFr6pVYDjw+LfP9UB9q2Q@mail.gmail.com>
X-Gm-Features: AclHuK95zom0Wqqrue6m7-lKPoAo3R_113cwV3WAYgHulj4dz6QgUcVJPRpgglw
Message-ID: <CAL4WiioPvWBTb7uq2ny=AApqoDst6fFr6pVYDjw+LfP9UB9q2Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] igc: prepare TSO and checksum offloads before TX timestamps
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, 
	chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, 
	horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, 
	matthew.vick@intel.com, aduyck@mirantis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 10:16, Paul Moses <p@1g4.org> a =C3=A9crit :
>
> igc_request_tx_tstamp() takes an extra skb reference before transmit
> preparation. For GSO packets, igc_tso() calls skb_cow_head(), which can
> reach pskb_expand_head() with a shared skb when the header is cloned.
> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, causing TSO
> preparation to fail and the packet to be dropped.
>
> For non-GSO packets with CHECKSUM_PARTIAL, igc_tx_csum() falls back to
> skb_checksum_help() for unsupported checksum offsets. This can also
> reach pskb_expand_head() through skb_ensure_writable(). igc_tx_csum()
> ignores the error, allowing transmission to continue without completing
> the checksum.
>
> Move TSO and checksum preparation before TX timestamp reservation so
> the extra skb reference cannot interfere with either operation.
>
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> Fixes: f38b782dccab ("igc: Add support for TSO")
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
