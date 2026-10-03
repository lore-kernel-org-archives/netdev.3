Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1244E642
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050237; cv=pass; b=YWvxcA9qDt9sMyuKvbTDVJBlgoYlCHGxWewU+Ee2jodDrmPPKTlFxtBCWObxqtxtOOENPJRJkN0kb3BKbO5xxeGthpZFp7WY+KRhiM9+6JDOPdddGUhRVvIw0j3M/bm0ZL0zrZwW+MfMYP2HKTCjoJ+xrlc6mrJLYq3cXJmhbnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050237; c=relaxed/simple;
	bh=4o0c9AbMgLO5vDHl5WhxxSOcXw34b6cKXqzLqEekp5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDktynma8tEasMWx8Jkrc3EO+vbDLOwVCv7gEp/OgcYAuNh1L2dvHTerdJcdLlClb6Eb8vXHtZI+p8I+9LKfVgv+EgUcgFf50YriViwzfT0vdI/GOGowd0bcZnkaUtGKcfFghOsy1vhKgpxLYLJ3mwCZLYlosZYY6gk5o0GDXf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8+q1thL; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8+q1thL"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144df39b6cfso358384c88.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791050235; cv=none;
        d=google.com; s=arc-20260327;
        b=RVNNZG/bqppWSvdt/GprKI4PrmfLK64aoLLtaK0bDkYyuccBVF72U3cQL59p6CldMb
         8nJKsqF2GMapxlqbOKiMyO7g47u3fAwLExABftZjZ/HO9ZXvT+Ujr6LFmK6jByVHP8d3
         cL1nbZrMK15hr6O9fVp/Uk8LAlaarkDH/NTpG9pvViCPTnbqGgloUNrmhk3193tjfoQp
         sH3uhMZUsHQs7TBF0c3q49vFQXksRsC27DULsEy5Epnc0WTdVuy9doszqnRxkOpntgzI
         mH5yywYXzbuFbjK4wJ1vAoTBkjXpPHedAAHs4+qsV/Sq/Mg/HTR8g1gUQVicyLf6HVfo
         AmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4o0c9AbMgLO5vDHl5WhxxSOcXw34b6cKXqzLqEekp5U=;
        fh=Yf0xtpwVAj9ixxkw3VU19apBM6rz/fKj+yjJGTjesIo=;
        b=b4LPemz7YgIHxh5ud4llRvvnqhu88PCQyq+SKRuvUeTiD0AHGBhJTiWqnw1xnoKXcU
         PrYdzoLjjqI0c2A6hZQkUP73sM9VikDDfCEHCxTa/F9nQTBXqSDWfl7CAEC2eCx/dUIk
         xv4YKiu03c1Shdrr1YwxQpyUcIgJXphITPPnB6v6h9VZRq033UUMXvnMOCrG1ZUl/xfz
         5DZmYm/yR7YP0OFpkSgB7KLpnqDhgWfrM4Ywjg9Sjck2GuB22wJc+Yqm3pd2ko8Twpr2
         vVhjhjb+t8hAKUzUgrlZtzd90eF9UeGaARyuUuZ/v8sTb0wpKGRDRBdmXeoHCmqbrZO5
         MDJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791050235; x=1791655035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4o0c9AbMgLO5vDHl5WhxxSOcXw34b6cKXqzLqEekp5U=;
        b=N8+q1thLT9XaPRwXcgp+bqIGGs0cEzXhfUCVGHSWpPVO7axVTiwnN5erwtA4MlFYof
         UCEeIav8VH02eVG/CWIvx2xexKYkJpVQivxxrqYxUyA7IBreA0quQhTvOXuDUmn3i6ru
         pRQWb2n6D9xFQyHh/NMcPGLPpbgxR9hNaFZoUCOeHYVBwxPaW/rovwK5dD35+E7pxyA/
         MuDTVPh+bTT8DURpaCc3eJYpS4Flk3iUO69A+njFZuHBb/XtYxOmv3XmFzD5fyBA/LrQ
         48CbRmdCojcJu3toh2xdUWCD34iT685iIsVMjCyDW3xSLDgnrHSPqTA4TLmTF6y87GKm
         Bxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791050235; x=1791655035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4o0c9AbMgLO5vDHl5WhxxSOcXw34b6cKXqzLqEekp5U=;
        b=RKJzE4On01JtPxgWXg9yY/TANZA6MZDWh5teht0r/gv7pkcsFphAWXjGm26WFE3siI
         rjgxHnc3RdGTv4i3V8Xwrr6xcoLOrkS9JzIrbSm5Y1dS9lcn26tVAQ7OMXzR08oqYvdj
         Cj6Y2IfOC2LrE+qhPj62lXgcvhNVqc+1e0xWgjV/PNcoxUOjmiVpbd5MUO7BRQhrg+2y
         yb/cLTuvHgkc7MAWaP5aU3KH+w0jgiPBbVrWcbrzxqokR4mkEVYL+PVkXvqyEt6+wPia
         V1GNfKRbbXChYN0SbKTvN1yHlag4cskWvaClNQ2D4RI36mXx9Orykt5dCID11+3aJRI+
         JSxQ==
X-Forwarded-Encrypted: i=1; AKwUvByXMGaF0U6+YhmK5YumVsmMowpnrPvbPyrwl6dRv08ZM/X2O5DJfhwK5fABm7Gur6vFSy40Hyk=@vger.kernel.org
X-Gm-Message-State: AFuF++l997Nk+6lhRbPlsOPOTv933km/eRssPrij4zvNTEC1Pn8rZT9E
	ZvGCOFPHAsG74fKLZ6DL0Bz1xOwiwJgNHRp9SQHZETdZuensOY/fxuWe6rPGwN3y7rvbjScDYjG
	o54WhMmmVksZD9ax/WIMZXKvADyPlGi7e0q45DetY
X-Gm-Gg: AYBFou1K0cprKin3pEiDdEt7asSpDeTtmRZmTsVOql31Sjuanp+BTMmn3koTerWOIbK
	rshPB/A3M4hz8EcGodfbP3WkltArwwi0kqAvcSxQ9Wr4xNcBtjbvagGUOcwhJRoIMP9F1V0qMa7
	yeB0mNqgznDAnZdCXaGX01ANuEYKqmxUU0SbaOMwJDKRPGiWzLKOdhVPfSGaOryagU+S7AQDMjT
	f1kXQjhbDBqP6Hhv6fwBfUzZJwcibn+2rsV+WFBczctEoKA7BS1QZj61uSC5h16Db74XmmbPPLu
	+xsCruaUYzxf4D+8e9fF2AigmgrImmpsAPsYl4NJfelMVyO8HHqKgScE2Gvscer4Jnqtq/XxzDt
	y9nIoPr8CeihjiaC2EYZDpqStQNdDqybBMzEqc1K0d3zPVVpshOVqeAs4seBlmy1JocHTl5CWBy
	5lWAQHzt3VBnc+2qGNQURikxOl
X-Received: by 2002:a05:701b:4254:20b0:141:4b89:7507 with SMTP id
 a92af1059eb24-14f5bffa0b0mr8585871c88.17.1791050234145; Sat, 03 Oct 2026
 10:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001221253.2964024-1-edumazet@kernel.org>
In-Reply-To: <20261001221253.2964024-1-edumazet@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 3 Oct 2026 10:57:02 -0700
X-Gm-Features: AclHuK-rI-8g-Sp0U360zcWzjLrhRanJdK5Wnq0-SZTbb5NJVPUjfdeT414nm_8
Message-ID: <CAAVpQUBZOa7fEVuby1HftNXZPVvQkmH8wmbPxTQH6LjfTb8gLQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipv4: free inet_opt and ireq_opt after an RCU
 grace period
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, edumazet@google.com, 
	netdev@vger.kernel.org, Xinyang Ge <xinyang@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 3:12=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> tcp_v4_syn_recv_sock() transfers ownership of ireq->ireq_opt to the
> child socket (newinet->inet_opt) without copying it.
>
> Another cpu can concurrently process a retransmitted SYN for the same
> request socket, and send a SYNACK from tcp_check_req().
> tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
> under rcu_read_lock() only, and ip_build_and_send_pkt() and
> ip_options_build() then read opt->optlen twice.
>
> Note that the SYNACK timer itself is not an issue: it holds a
> reference on its request socket, and inet_csk_reqsk_queue_drop()
> calls timer_delete_sync() before the child can be freed.
>
> Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> into ehash table"), request sockets are processed without holding
> the listener lock, so nothing prevents the child socket from being
> freed while the SYNACK is still being built. TCP child sockets do
> not have SOCK_RCU_FREE, and inet_sock_destruct() frees inet_opt
> with a plain kfree(), leading to a use-after-free in
> ip_options_build().
>
> A similar issue exists with request socket migration
> (net.ipv4.tcp_migrate_req=3D1, or a BPF_SK_REUSEPORT_SELECT_OR_MIGRATE
> program). reqsk_timer_handler() clones the request socket with
> inet_reqsk_clone(), so that the old request socket and its clone
> share the same ireq_opt, then reqsk_migrate_reset() clears the
> pointer in the old one. Another cpu holding a reference on the old
> request socket can still be using these options (sending a SYNACK,
> or creating a child in tcp_v4_syn_recv_sock()) when the clone is
> freed, and tcp_v4_reqsk_destructor() also uses a plain kfree().
>
> Readers already use RCU, and other paths replacing inet_opt
> (do_ip_setsockopt(), cipso_v4_sock_setattr()...) already use
> kfree_rcu(). Use kfree_rcu() in inet_sock_destruct() and
> tcp_v4_reqsk_destructor() as well.
>
> IPv6 is not affected by the first issue, because tcp_v6_syn_recv_sock()
> duplicates the options. tcp_v6_reqsk_destructor() has the same
> migration issue with ipv6_opt, which is only set by CALIPSO. This
> will be addressed in a separate patch.
>
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash tabl=
e")
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmi=
tting SYN+ACKs.")
> Reported-by: Xinyang Ge <xinyang@anthropic.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
