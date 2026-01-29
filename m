Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107082F6590
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715656; cv=pass; b=if0lQK3gayJCS0kXOUYsWBa0ijGaLuiRrKag1Ym1MFZzhQiJpmgDV+8UMb8nTbJwyihUhSayh5HpEiY8pK9L4VNIzjKzdA+trVPCT9GqTqlQ8Codh1+P7uhlH+NXswqaa+1wNsxYXEkHkHaqmErONdp/1CNmare+ra7hFD7/tak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715656; c=relaxed/simple;
	bh=OQufuj5kkmYMxx6ttww64CZWm+ndiofyh3a3rNhNfCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+sH9JN2gLZCqTkM2X/ifQjWIsrva8dn1CHwh7eDBeJnZzRa2QRJ2JJO0SE4eh3jL7Sb//Vbubncsv11ZY89aLXdTQEHquH1DU93eXxn1IXF6P+JRqLyvriF68pUBXCmcl0MGNbzblzJQeB4vAWA50pFG2rWxVFpZkys1DnIt68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDUaVZHL; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDUaVZHL"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5f52fa0d48dso412465137.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:40:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769715654; cv=none;
        d=google.com; s=arc-20240605;
        b=GzPEUJWFj81eFFmDXWAmtspG1EGv8V17y6D0ipvCLB/cjQFq3+CR4nTQLux4xf8BuA
         ZghL9mUTJGKny/dNdPAYqw1F4A751zfpUs+lkDvrNAGptVtlU6hA3XbXTkxbjfd1ab1M
         gErUwhoA7J/N1FNVCRIj8ws6TX7RiD6Jdubgx+NyuNj2rX4EeeAFDY2+Op8/AiyueyW/
         6fAdsF2VDUh3Rr/AZgaJQlUterkZKq4IoK8Vg0Ait44vs8T8DFFhyVqOEpXvA/RyMSVV
         MCmk1YfDRQvd1tBzJOabKBG7jCRugWhN7FlX2QJ+brDKArqzghrRBBdM9Iy0x0P2t+vB
         Z84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWXOUBeb3b+nw5Cfis8wSYxSsjd/F4GCHIXMwqvZur4=;
        fh=fDbUfIcx4Ncec9AV4wxOHXS/c8ilfxJ4Jm8OWBj8/eg=;
        b=TPCEg6YwnXw5BoBKyMJUXT5uvQYeIbZkaH9qD9I8PTX/PFUTM6l8HWh3cZAHqFwAF5
         r1jdfoVbtqx+oq1qFdgIigBy6fUVRrw3vtsCdUl+1R0bb/O+3iaZ28oJ6bK9cp5GYp6K
         +gvqJM522/pYa+ttlXz5jzxmwk6fOc7VPti0oNc3JVBs1R20vl6T0GxzGU2wpyFPxQJl
         EQX0JXkqVxZXbafrYiZlkNycDruDU3SSLQfZuxqEFw97p738qkItdAFqnAoSiVqFRSvr
         EjoCe4cnc3+/C3Iph9W7jWnnFKsVZutLaqeTweYI6UkrnDrgQmKdERct3CBJeWAIH4zn
         YioA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715654; x=1770320454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWXOUBeb3b+nw5Cfis8wSYxSsjd/F4GCHIXMwqvZur4=;
        b=TDUaVZHLKS6j8mBQqgRKfis+WbqxJrpZLP6/Xvs0c3IEw8N2Cmsmn2ZLJUljZSeULi
         YLt50yi0EpsnbAVU0Kam8JKrRFpMcyE8J4N7xOpJ1YuFCE1IziipaSTAqGpxLLUeCWZF
         7rRjbV5T21seHDGe89XVSx7JWPNdoK3DzjRkjpMH7u1np7+IWm6fFrNrDnbN7q/+8zJx
         i/MCvMOy1UiN0xAsXsUwQMIP2KVfPCYyIhO79+cHR0vv7GMApT3N50WP31XHZiIV5XWT
         1PUPignZ5q6gMwP8VcxpNYKVrfXZ7tFUR2qsR2yyGiMAZ7dTvugzHjYu/P9fkpd4BtJu
         wJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715654; x=1770320454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWXOUBeb3b+nw5Cfis8wSYxSsjd/F4GCHIXMwqvZur4=;
        b=sfFHuXIdnaMDeWxmq6hxQcZqR/hBlk9Qhs1CJvJN3q2wp3B81TxYljzvjbUmzWkfNZ
         8+Ovi7dZ9KqmrYSCSxIkqIauZ9z5jYrGTN7ndBUc1EhU3bMntMHTBSKygxe2BwUdB7/S
         dBTdFGuX0/5zUhFJfjD6gUSR3aPCMepIi81LKZM/isKyaDCkQS9KLCIRM8SZ6Vf6A3Vq
         HPydpwbV0uPoBQnygI8JVMK64vhH+ikoQ+h9lq3iv6DQykwZigNZb9nmbcR4MXQdRM18
         P9rZme6K+2ijGkBaFTUXJKRH2ERWOT5J8vdmErJUN7Ox61uvyAKgsyRRm4irdHF36XZ8
         YK4g==
X-Gm-Message-State: AOJu0YywOK5MfnwDpgqkdsIGGj82DcdttRzgIj0L5HlaEHXqkVRKVEDC
	6Ttlam7iitufypfMcyZTrfiOWOXMM628lIq4AUb59PwvFEmR9VPa9+SjR4OsUZ0hXJPNo+RjwqF
	+C6dqYmdWpt6vFVzZusdAOkzMucygYqea7NZVeGLDUw==
X-Gm-Gg: AZuq6aJ5TnGGIdwfHwOXBTZY5pCWsjL22G5DS/zc4kXATN+KCcSpXV49p6VZJ5EOjfg
	e9xuV9hmE9gFmJ2Z3Bgpu4fetKcVdrVM3GLe9OqC7b8SKDmQExtSZbNGADJpBv5fbYZ/xoP2fzq
	tGBwWDaMiDsU0dJmEpLuD55zoXZY1RvzxvpcvKiCuMOgrNTF6YGsqpSVjY3u9hD7Gk8p6yZvSRd
	7UwWpAKWknOnQQxLyJXNh6VuS2JSgLwu+iqB2H+lNYA2rosvLWbp1BAnucdfV9xnY/UrmzyHvMD
	oEJZnMeJw3raCUhyAJv4NxX1R5t1Tw==
X-Received: by 2002:a05:6102:304e:b0:5f5:2e08:bbab with SMTP id
 ada2fe7eead31-5f8e23e7d3amr226299137.6.1769715653861; Thu, 29 Jan 2026
 11:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769439073.git.lucien.xin@gmail.com> <1cbfbd45fda48c82f629b000fc102ee011515e12.1769439073.git.lucien.xin@gmail.com>
 <9c17e0f5-0a07-4800-9356-0ee9445e3922@redhat.com>
In-Reply-To: <9c17e0f5-0a07-4800-9356-0ee9445e3922@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 29 Jan 2026 14:40:40 -0500
X-Gm-Features: AZwV_Qjx14-1bOrrh8LVqqfM15IbyrS2KpNfixIqKIZVNgumQoCFAq17MEBRSlw
Message-ID: <CADvbK_f7++7shAGwYLcz=ph-te_d+z+bMxiaTtY2Ahze+Wagqg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 03/15] quic: provide common utilities and data structures
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/26/26 3:51 PM, Xin Long wrote:
> > +struct quic_skb_cb {
> > +     /* Callback and temporary context when encryption/decryption comp=
letes in async mode */
> > +     void (*crypto_done)(struct sk_buff *skb, int err);
> > +     void *crypto_ctx;
> > +     union {
> > +             struct sk_buff *last;   /* Last packet in bundle on TX */
> > +             u64 time;               /* Arrival timestamp in UDP tunne=
l on RX */
> > +     };
> > +     s64 number;             /* Parsed packet number, or the largest p=
reviously seen */
> > +     u32 seqno;              /* Dest connection ID number on RX */
> > +     u16 errcode;            /* Error code if encryption/decryption fa=
ils */
> > +     u16 length;             /* Payload length + packet number length =
*/
> > +
> > +     u16 number_offset;      /* Offset of packet number field */
> > +     u8 number_len;          /* Length of the packet number field */
> > +     u8 level;               /* Encryption level: Initial, Handshake, =
App, or Early */
> > +
> > +     u8 key_update:1;        /* Key update triggered by this packet */
> > +     u8 key_phase:1;         /* Key phase used (0 or 1) */
> > +     u8 backlog:1;           /* Enqueued into backlog list */
> > +     u8 resume:1;            /* Crypto already processed (encrypted or=
 decrypted) */
> > +     u8 path:1;              /* Packet arrived from a new or migrating=
 path */
> > +     u8 ecn:2;               /* ECN marking used on TX */
> > +};
> > +
> > +#define QUIC_SKB_CB(skb)     ((struct quic_skb_cb *)&((skb)->cb[0]))
>
> Please add a build time check on quic_skb_cb size.
>
I may put this in quic_init():

BUILD_BUG_ON(sizeof(struct quic_skb_cb) > sizeof_field(struct sk_buff, cb))=
;

thanks.
