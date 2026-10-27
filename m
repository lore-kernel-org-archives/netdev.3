Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091324;
	b=wfn8cOskrc1vqb9UdkYsnSjYTnmQKxdBcppWMchK8PVhumBtgxBelGs/B+zVHONJfGuZ
	 Y3JL8zOAjL5d0IZRtLulmCfLxxfoaa9fh+bJY3vodeW3SSiYKSB/EG6tzaOD3a2tt5S1b
	 znCtBYSXwotU6mX2QeK1YuYqR6/JLnN7mGqjlXzQH8KjpEu8TbHm4c7ZapDzZ+JHQXUgr
	 d1AAFxa23NoX27HugfjDLvX1sMDMQc234ZSA7PR8FcRNR6rzzMS1TX1D4riOYe3dRBcQ5
	 jFppHKjRoUbJaPUQWF4J7pctKi+wsvU0ymizVvHg/3+7oJJZeI2rCrZiepIOCTnB3yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091324;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vFE78Mt/RT5W0a8LHAY83nSeo9T+I0JI1DQ+N1in6PI=;
	b=EDgbZEWSHP25IT2+MdngwgvyG/FA0olzRK4w5luGOfbTmJUxpkQskN7A0YA+Zgw9OVrt
	 bZn4ZNJesU0xFALY5vxmopbtp/45jgPb5SypJl/530Tda1DPVbnq8ygeLUFoJN8wmzGjY
	 NnpByhHHkPRDP3giXsoujI4rfNk630FdrQEgXLF5QdQ9gaNUMuCYe/wUl4oCOObzCXOKE
	 adSHeRXhYSsMGVDn1BqQ37FqNRLNWE8wgvgGZ6h9TLApHIJ4VUnIrG389RyfX2FSLcgti
	 GjwM4ZuJrXe6U49147ronF9Pa8URa0CYTpWw8UlSV/Opyk729782mqdWZCKBf3/c7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNGRAl9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC04606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNGRAl9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F91F01828;
	Tue, 27 Oct 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091323;
	bh=vFE78Mt/RT5W0a8LHAY83nSeo9T+I0JI1DQ+N1in6PI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WNGRAl9Gd0g1s15kSqpVJRpYgTPn7+MFJUq1xqRJScXXnTquyRYh+JmMb/4aRn/KO
	 En85SvqTAJwXjGswzKlezVeHAY15G4RdXgSRPU3urQacquTurGoLI/MKdgnFqOcYJF
	 b2MWyeU4V43Vrz4FbFcpjI1LNJzF2Zu76RXqiv0dL4Hggi/g75JfGl9GIVYURUGU9l
	 YmC/V49GQPx5BigOyvER+WZ7qwJSIrjh4/6Nhbymq/PICAsC5OEiheBuoq122hyUiG
	 +cLOdNQSYf2XCoCe2CYeQOSw6AcW07ia0eWaOO3kpjsTQybtO8pdgxJL5oJuHJ4ASD
	 VLdrHtT4+esag==
Subject: Re: [PATCH net 07/10] batman-adv: tt: only transmit local ROAM flag
 together with DEL
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:22 +0000
Message-ID: <179309132249.3134.16887364336514212941@kernel.org>
In-Reply-To: <20261026085309.1074911-8-sw@simonwunderlich.de>
References: <20261026085309.1074911-8-sw@simonwunderlich.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix leaves the requester-side client drop in place even
  though the commit message lists it as a symptom, and the message…

--

batman-adv: tt: only transmit local ROAM flag together with DEL

This patch stops local TT entries from sending BATADV_TT_CLIENT_ROAM
unless it comes with BATADV_TT_CLIENT_DEL. The ROAM bit is now cleared
for non-DEL events in __batadv_tt_local_event() and for full table
responses in batadv_tt_local_valid(). The goal is to stop receivers from
treating a plain ADD as a roaming advertisement.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 3349376a9087d..39b61426f1680 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -3342,8 +3350,12 @@ static bool batadv_tt_local_valid(void *entry_ptr,
>  	if (tt_flags & BATADV_TT_CLIENT_NEW)
>  		return false;
>  
> +	/* the entry is (still) announced. A ROAM flag of an entry which is
> +	 * pending to be removed must not be transmitted. Otherwise, the
> +	 * receiver would handle it like a roaming advertisement
> +	 */
>  	if (flags)
> -		*flags = tt_flags;
> +		*flags = tt_flags & ~BATADV_TT_CLIENT_ROAM;
>  
>  	return true;
>  }

[Severity: Medium]

Does this fix the requester-side symptom described in the commit
message? The commit message says:

  When the requester is the node which sent the ROAMING_ADV, it then
  marks its own (new) local client as roamed back to the old originator
  and drops it when it is still NEW.

After this change, batadv_tt_local_valid() still reports an entry that
batadv_tt_local_mark_removed() marked ROAM|PENDING as valid. It only
clears the ROAM bit. So the entry still goes out as a plain ADD in the
full table response built by batadv_send_my_tt_response().

Take node B, which sent the ROAMING_ADV for client C to the old
originator A. B gets A's full table response before A's next TT commit:

batadv_tt_fill_gtable()
  batadv_tt_global_del_orig(bat_priv, orig_node, -1, "Received full table")
    /* removes B's ROAM-marked global entry for C if A was the only orig */
  _batadv_tt_update_changes()
    batadv_tt_global_add(..., flags without ROAM, ...)
      out_remove:
      batadv_tt_global_purge_local(bat_priv, tt_global_entry, flags)
        batadv_tt_local_remove(..., flags & BATADV_TT_CLIENT_ROAM) /* false */
          batadv_tt_local_mark_removed()
              if (common->flags & BATADV_TT_CLIENT_NEW)
                  break;
          batadv_tt_local_remove_now()

The NEW check in batadv_tt_local_mark_removed() does not depend on
roaming. B's newly roamed-in local entry for C is therefore still
removed right away by batadv_tt_local_remove_now(). If the entry was
already committed, a DEL is queued instead. B's global table then
points C at A.

On A, the local entry for C is ROAM|PENDING, so batadv_is_my_client()
returns false there as well. Would traffic for C then be disrupted
until C sends another frame through B and batadv_tt_local_add()
recreates the entry?

The first bullet list in the commit message also has a related
statement:

  * batadv_tt_global_purge_local() removes a local entry of the receiver

It is listed there as an effect of an ADD carrying ROAM. However,
batadv_tt_global_add() reaches out_remove and calls
batadv_tt_global_purge_local() on every successful non-multicast global
add, whether or not ROAM is set. ROAM only selects the roaming argument
passed to batadv_tt_local_remove().

Is more needed to keep B from dropping its local client in this case?
If not, should the commit message say that this patch only fixes the
ROAM marking of the global entry and the resulting CRC mismatch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
