Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF63CF21F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894151; cv=none; b=EMKpGrLmrEx64XKp3U8SyXoXZ8jtWCXiJYSdPcV704QUd2zBrMyp9wrwGkYEQzb3OYefWAm9TSfgsgbPuIMc6Qv50UHJ80uvZMyvVxO64+Gn8x7Nq8M2s+SI+ySLe+bIgX9ibWryjW2h8/Ud8wQcFKd+KqHkUcdd7cf71bw5Yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894151; c=relaxed/simple;
	bh=T7LdSwUdufFe+ksVY0npO7TNcPwWAFre4gP83+3oqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5ZF41yaNzPkUd7KMqKLhzutjNmm/tw9m/kP97ayGgKrTCp0OWhe/2bEybaeQFTmwyw2GiSf0jYtpr/WRNOuJXc0CvGrshw4DhyxbG41N51c4pMzyOR7nYTRUE6MEM37wJQS49C5huuDpAk0mILDDgM10dHUBte5sujTrJRZQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfOIZ2xa; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfOIZ2xa"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso22207145e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790894132; x=1791498932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVwsyaNyqHLnRNMhj5+S7DnvOUhJX5e9L6a+bmtKI50=;
        b=rfOIZ2xaKSJgFjxS/WDmha744psbgklXDPQS+h+xrSYRahuKQZepPL8NnYJmHggRNr
         qb1LjIgktyj1UH+joKF3QpCBNgTLwpQHKyKjCiUkfn32mC/wkvOdE1obgim7cZNxvqAt
         KH16CIqF9bdY6exTwD7QGyqagwfq0kAAyKnMlcMb0al2qDztAyZ9cHuO0s7s/6+PA7dF
         vCQ4S3RQ7Ai5KsO0ZM74wKiyrdWLcU2Vo50vmNarVnl0MsS3u/OzMZNdQ8FyL6Ds21Se
         svwe3dhvx6bwmDZsE9e2HM4jTI/btquVJ8CfNTHGLakbfPN2bKT9gcZA4r2gKjnleVkE
         OqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894132; x=1791498932;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVwsyaNyqHLnRNMhj5+S7DnvOUhJX5e9L6a+bmtKI50=;
        b=LwDMrGL7x47GjC+ghMBLgqRBllVCHog6K6tsXNUsVFusEBqd0QYNJul5FXPpsE5rQW
         SAWMlXlplLECbBbkhB4hUhHvtmuok7stRMP0a3ZErBTUmCnRJ+kzhRq7TCi+d+CAyAER
         fn1XCl2VGgbzubnVT5q8yZg3tCG3cLOi89Cj5Gr5UrtqIIjl5wWQDe6hpqjsOME137jo
         Co2GLqV+kbuMzG5Uhf4Vt3GR6twAT9ilzBXkWYGRM4vR5//Skt4vwQHTwPXcELVGeEOi
         UXLnsMFbNapu/L9/c4yLzay89iM/TMmUAAwDaCTlDR3gTkptxJZC954kz7HsVdioAxjP
         h6Bw==
X-Forwarded-Encrypted: i=1; AKwUvBziT6mmzf3UNzZnhGEZ0YWuLS57CyJrfYPugdFxVlrWDwICH276NLgduTBW7AyoB1jZfNHopfA=@vger.kernel.org
X-Gm-Message-State: AFuF++mPczNc6R99QeTIvTrHEeW4JaC+/3OlrEzQM9Tuod0lM5F5g6jO
	q/jf8OErC1XLNsgKZmfQWGTTbUVKqfFwh0pzSBPJ3xsy6pK9DfyBqPCF
X-Gm-Gg: AYBFou2ekWpxt/PkROstRlTEsxeboDIiA6g6m/JSzTaaCDDaWyjtu4zlYm5hIZpCaH4
	R7QWY9SxNg/8uwDUu47Z3JP2UILHdCxyEbwgk3YQ8+OI+Sg84jVrU0Y2yLVSQ7XrDMf0KXSZFC6
	jHU9lz0eHqLrpaQQZJmZg7A+jqru5K0aGNYtDpGS8PoVI4dXz/yCaAhKI57rC5i523voX7tQwH0
	3cxHdP3wsTqMZlO5zlJ507/FzwbiHDZS1hierSSS1UlK2UY/Tr2hdlh0Jl66EBpSRlIIMywDSmU
	zMJ9HlW2Q/4Ye+5Ik0Ragqsza9sVxPpkBUNUwLUqF25WSDK/rXTK3lMbxuycRmpD1xXs/hl6lXt
	HsVTpJ1+7TrYrmufogvqw/krNr3nUd+8+CCXqV2yCXLXa6PN4PrhE/DlbK6/SWcCYpmj4ExLxTs
	myu4PzD7bMfra3Q8LPCbhU+MRmfC8xc6rc++9eQwF36yL4VUQQz9tRS/DYpzKb9icWmUQaYOLcz
	2Ev8gZr7koLwzEqYFsnRJvkyykF80JAYcA=
X-Received: by 2002:a05:600c:19c8:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-4a02752340emr16656795e9.4.1790894131192;
        Thu, 01 Oct 2026 15:35:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff20831sm6434445e9.4.2026.10.01.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 15:35:30 -0700 (PDT)
Date: Thu, 1 Oct 2026 23:35:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kernel@xen0n.name, chenhuacai@kernel.org, tsbogend@alpha.franken.de,
 deller@gmx.de, razor@blackwall.org, idosch@nvidia.com, aconole@redhat.com,
 ardb@kernel.org, tim.bird@sony.com, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Ernestas Kulik
 <ernestas.k@iconn-networks.com>
Subject: Re: [PATCH net-next 1/3] llc: move the type 2 sockets out of tree
Message-ID: <20261001233528.3bad1a4b@pumpkin>
In-Reply-To: <20260928190800.2521749-2-kuba@kernel.org>
References: <20260928190800.2521749-1-kuba@kernel.org>
	<20260928190800.2521749-2-kuba@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 12:07:58 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> 802.2 LLC is only used in tree by protocols which need the
> connectionless type 1 subset: STP, which carries the bridge's BPDUs,
> GARP, which sends its own UI PDUs, and SNAP. The llc2 module on top of
> the core - the type 2 connection state machine, the type 1 SAP state
> machine, the station component and the PF_LLC socket family - has no
> in-kernel users and nobody who can test it; what we get instead is a
> slow trickle of drive-by fixes.
> 
> There was a recent patch from Ernestas Kulik indicating potential
> real life use, but it was new/experimental and that person is
> not responding to off-list pings.
> 
> Let LLC2 follow AX.25, hamradio and AppleTalk out of the Linux tree.
> We will maintain the code at: github.com/linux-netdev/mod-orphan
> for anyone interested in playing with it.

As far as I remember the only historic use of LLC2 was netbeui
(which I've probably misspelled).
That was really replaced by NetBios of TCP.
So we are in the age of 8-bit ISA ethernet cards that stood no chance
of receiving the 15 back-to-back ethernet frames they issued credit for.
Oh, and another stunningly bad ISA card that sometimes failed to indicate
there was a frame in its rx fifo (for pio reads) until the following
frame arrived (even the fifo byte count was wrong).
I can't remember exactly why that completely broke llc2.

David 

> 
> PF_LLC goes in full, both the class two SOCK_STREAM and the class one
> SOCK_DGRAM half, and so do /proc/net/llc/ and /proc/sys/net/llc/. Note
> that the kernel also stops answering XID and TEST commands, addressed
> to a SAP or to the station - those are type 1, but they lived in the
> module, and they got answered whether or not any socket was open.
> Nothing in tree asks for them; what the core keeps is SAP registration
> and the UI path the in-tree users need.
> 
> Retain the uAPI for now, like we did for AppleTalk. Only the socket ABI
> half of it is vestigial: STP, GARP, the bridge and openvswitch use the
> SAP numbers it defines. Cleaning up what the core no longer needs
> follows in the next patch.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: Ernestas Kulik <ernestas.k@iconn-networks.com>
> ---
>  net/llc/Kconfig                             |    7 -
>  net/llc/Makefile                            |   10 +-
>  include/linux/llc.h                         |    5 -
>  include/net/llc.h                           |   26 -
>  include/net/llc_c_ac.h                      |  180 -
>  include/net/llc_c_ev.h                      |  217 -
>  include/net/llc_c_st.h                      |   46 -
>  include/net/llc_conn.h                      |  114 -
>  include/net/llc_if.h                        |   63 -
>  include/net/llc_s_ac.h                      |   35 -
>  include/net/llc_s_ev.h                      |   61 -
>  include/net/llc_s_st.h                      |   32 -
>  include/net/llc_sap.h                       |   26 -
>  net/llc/af_llc.c                            | 1304 -----
>  net/llc/llc_c_ac.c                          | 1448 ------
>  net/llc/llc_c_ev.c                          |  742 ---
>  net/llc/llc_c_st.c                          | 4940 -------------------
>  net/llc/llc_conn.c                          | 1025 ----
>  net/llc/llc_if.c                            |  151 -
>  net/llc/llc_input.c                         |    1 -
>  net/llc/llc_pdu.c                           |  366 --
>  net/llc/llc_proc.c                          |  245 -
>  net/llc/llc_s_ac.c                          |  220 -
>  net/llc/llc_s_ev.c                          |  109 -
>  net/llc/llc_s_st.c                          |  177 -
>  net/llc/llc_sap.c                           |  437 --
>  net/llc/llc_station.c                       |  120 -
>  net/llc/sysctl_net_llc.c                    |   71 -
>  arch/loongarch/configs/loongson32_defconfig |    1 -
>  arch/loongarch/configs/loongson64_defconfig |    1 -
>  arch/mips/configs/gpr_defconfig             |    1 -
>  arch/mips/configs/mtx1_defconfig            |    1 -
>  arch/mips/configs/rb532_defconfig           |    1 -
>  arch/parisc/configs/generic-32bit_defconfig |    1 -
>  34 files changed, 1 insertion(+), 12183 deletions(-)
>  delete mode 100644 include/net/llc_c_ac.h
>  delete mode 100644 include/net/llc_c_ev.h
>  delete mode 100644 include/net/llc_c_st.h
>  delete mode 100644 include/net/llc_conn.h
>  delete mode 100644 include/net/llc_if.h
>  delete mode 100644 include/net/llc_s_ac.h
>  delete mode 100644 include/net/llc_s_ev.h
>  delete mode 100644 include/net/llc_s_st.h
>  delete mode 100644 include/net/llc_sap.h
>  delete mode 100644 net/llc/af_llc.c
>  delete mode 100644 net/llc/llc_c_ac.c
>  delete mode 100644 net/llc/llc_c_ev.c
>  delete mode 100644 net/llc/llc_c_st.c
>  delete mode 100644 net/llc/llc_conn.c
>  delete mode 100644 net/llc/llc_if.c
>  delete mode 100644 net/llc/llc_pdu.c
>  delete mode 100644 net/llc/llc_proc.c
>  delete mode 100644 net/llc/llc_s_ac.c
>  delete mode 100644 net/llc/llc_s_ev.c
>  delete mode 100644 net/llc/llc_s_st.c
>  delete mode 100644 net/llc/llc_sap.c
>  delete mode 100644 net/llc/llc_station.c
>  delete mode 100644 net/llc/sysctl_net_llc.c
> 
> diff --git a/net/llc/Kconfig b/net/llc/Kconfig
> index 7f79f5e134f9..81bfeaed6443 100644
> --- a/net/llc/Kconfig
> +++ b/net/llc/Kconfig
> @@ -1,10 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config LLC
>  	tristate
> -
> -config LLC2
> -	tristate "ANSI/IEEE 802.2 LLC type 2 Support"
> -	select LLC
> -	help
> -	  This is a Logical Link Layer type 2, connection oriented support.
> -	  Select this if you want to have support for PF_LLC sockets.
> diff --git a/net/llc/Makefile b/net/llc/Makefile
> index 46b1cd905ffd..17a8a2610b28 100644
> --- a/net/llc/Makefile
> +++ b/net/llc/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  ###########################################################################
> -# Makefile for the Linux 802.2 LLC (fully-functional) layer.
> +# Makefile for the Linux 802.2 LLC layer.
>  #
>  # Copyright (c) 1997 by Procom Technology,Inc.
>  #		2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> @@ -9,11 +9,3 @@
>  obj-$(CONFIG_LLC) += llc.o
>  
>  llc-y := llc_core.o llc_input.o llc_output.o
> -
> -obj-$(CONFIG_LLC2) += llc2.o
> -
> -llc2-y := llc_if.o llc_c_ev.o llc_c_ac.o llc_conn.o llc_c_st.o llc_pdu.o \
> -	  llc_sap.o llc_s_ac.o llc_s_ev.o llc_s_st.o af_llc.o llc_station.o
> -
> -llc2-$(CONFIG_PROC_FS) += llc_proc.o
> -llc2-$(CONFIG_SYSCTL)  += sysctl_net_llc.o
> diff --git a/include/linux/llc.h b/include/linux/llc.h
> index 944e9e213112..c03bb12bcc9c 100644
> --- a/include/linux/llc.h
> +++ b/include/linux/llc.h
> @@ -9,9 +9,4 @@
>  
>  #include <uapi/linux/llc.h>
>  
> -#define LLC_SAP_DYN_START	0xC0
> -#define LLC_SAP_DYN_STOP	0xDE
> -#define LLC_SAP_DYN_TRIES	4
> -
> -#define llc_ui_skb_cb(__skb) ((struct sockaddr_llc *)&((__skb)->cb[0]))
>  #endif /* __LINUX_LLC_H */
> diff --git a/include/net/llc.h b/include/net/llc.h
> index 029ba8a22319..8ea44ed98c4d 100644
> --- a/include/net/llc.h
> +++ b/include/net/llc.h
> @@ -130,30 +130,4 @@ struct llc_sap *llc_sap_find(unsigned char sap_value);
>  
>  int llc_build_and_send_ui_pkt(struct llc_sap *sap, struct sk_buff *skb,
>  			      const unsigned char *dmac, unsigned char dsap);
> -
> -void llc_sap_handler(struct llc_sap *sap, struct sk_buff *skb);
> -void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb);
> -
> -void llc_station_init(void);
> -void llc_station_exit(void);
> -
> -#ifdef CONFIG_PROC_FS
> -int llc_proc_init(void);
> -void llc_proc_exit(void);
> -#else
> -#define llc_proc_init()	(0)
> -#define llc_proc_exit()	do { } while(0)
> -#endif /* CONFIG_PROC_FS */
> -#ifdef CONFIG_SYSCTL
> -int llc_sysctl_init(void);
> -void llc_sysctl_exit(void);
> -
> -extern int sysctl_llc2_ack_timeout;
> -extern int sysctl_llc2_busy_timeout;
> -extern int sysctl_llc2_p_timeout;
> -extern int sysctl_llc2_rej_timeout;
> -#else
> -#define llc_sysctl_init() (0)
> -#define llc_sysctl_exit() do { } while(0)
> -#endif /* CONFIG_SYSCTL */
>  #endif /* LLC_H */
> diff --git a/include/net/llc_c_ac.h b/include/net/llc_c_ac.h
> deleted file mode 100644
> index af31a49bebb0..000000000000
> --- a/include/net/llc_c_ac.h
> +++ /dev/null
> @@ -1,180 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_C_AC_H
> -#define LLC_C_AC_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -/* Connection component state transition actions */
> -/*
> - * Connection state transition actions
> - * (Fb = F bit; Pb = P bit; Xb = X bit)
> - */
> -
> -#include <linux/types.h>
> -
> -struct sk_buff;
> -struct sock;
> -struct timer_list;
> -
> -#define LLC_CONN_AC_CLR_REMOTE_BUSY			 1
> -#define LLC_CONN_AC_CONN_IND				 2
> -#define LLC_CONN_AC_CONN_CONFIRM			 3
> -#define LLC_CONN_AC_DATA_IND				 4
> -#define LLC_CONN_AC_DISC_IND				 5
> -#define LLC_CONN_AC_RESET_IND				 6
> -#define LLC_CONN_AC_RESET_CONFIRM			 7
> -#define LLC_CONN_AC_REPORT_STATUS			 8
> -#define LLC_CONN_AC_CLR_REMOTE_BUSY_IF_Fb_EQ_1		 9
> -#define LLC_CONN_AC_STOP_REJ_TMR_IF_DATA_FLAG_EQ_2	10
> -#define LLC_CONN_AC_SEND_DISC_CMD_Pb_SET_X		11
> -#define LLC_CONN_AC_SEND_DM_RSP_Fb_SET_Pb		12
> -#define LLC_CONN_AC_SEND_DM_RSP_Fb_SET_1		13
> -#define LLC_CONN_AC_SEND_DM_RSP_Fb_SET_F_FLAG		14
> -#define LLC_CONN_AC_SEND_FRMR_RSP_Fb_SET_X		15
> -#define LLC_CONN_AC_RESEND_FRMR_RSP_Fb_SET_0		16
> -#define LLC_CONN_AC_RESEND_FRMR_RSP_Fb_SET_Pb		17
> -#define LLC_CONN_AC_SEND_I_CMD_Pb_SET_1			18
> -#define LLC_CONN_AC_RESEND_I_CMD_Pb_SET_1		19
> -#define LLC_CONN_AC_RESEND_I_CMD_Pb_SET_1_OR_SEND_RR	20
> -#define LLC_CONN_AC_SEND_I_XXX_Xb_SET_0			21
> -#define LLC_CONN_AC_RESEND_I_XXX_Xb_SET_0		22
> -#define LLC_CONN_AC_RESEND_I_XXX_Xb_SET_0_OR_SEND_RR	23
> -#define LLC_CONN_AC_RESEND_I_RSP_Fb_SET_1		24
> -#define LLC_CONN_AC_SEND_REJ_CMD_Pb_SET_1		25
> -#define LLC_CONN_AC_SEND_REJ_RSP_Fb_SET_1		26
> -#define LLC_CONN_AC_SEND_REJ_XXX_Xb_SET_0		27
> -#define LLC_CONN_AC_SEND_RNR_CMD_Pb_SET_1		28
> -#define LLC_CONN_AC_SEND_RNR_RSP_Fb_SET_1		29
> -#define LLC_CONN_AC_SEND_RNR_XXX_Xb_SET_0		30
> -#define LLC_CONN_AC_SET_REMOTE_BUSY			31
> -#define LLC_CONN_AC_OPTIONAL_SEND_RNR_XXX_Xb_SET_0	32
> -#define LLC_CONN_AC_SEND_RR_CMD_Pb_SET_1		33
> -#define LLC_CONN_AC_SEND_ACK_CMD_Pb_SET_1		34
> -#define LLC_CONN_AC_SEND_RR_RSP_Fb_SET_1		35
> -#define LLC_CONN_AC_SEND_ACK_RSP_Fb_SET_1		36
> -#define LLC_CONN_AC_SEND_RR_XXX_Xb_SET_0		37
> -#define LLC_CONN_AC_SEND_ACK_XXX_Xb_SET_0		38
> -#define LLC_CONN_AC_SEND_SABME_CMD_Pb_SET_X		39
> -#define LLC_CONN_AC_SEND_UA_RSP_Fb_SET_Pb		40
> -#define LLC_CONN_AC_SEND_UA_RSP_Fb_SET_F_FLAG		41
> -#define LLC_CONN_AC_S_FLAG_SET_0			42
> -#define LLC_CONN_AC_S_FLAG_SET_1			43
> -#define LLC_CONN_AC_START_P_TMR				44
> -#define LLC_CONN_AC_START_ACK_TMR			45
> -#define LLC_CONN_AC_START_REJ_TMR			46
> -#define LLC_CONN_AC_START_ACK_TMR_IF_NOT_RUNNING	47
> -#define LLC_CONN_AC_STOP_ACK_TMR			48
> -#define LLC_CONN_AC_STOP_P_TMR				49
> -#define LLC_CONN_AC_STOP_REJ_TMR			50
> -#define LLC_CONN_AC_STOP_ALL_TMRS			51
> -#define LLC_CONN_AC_STOP_OTHER_TMRS			52
> -#define LLC_CONN_AC_UPDATE_Nr_RECEIVED			53
> -#define LLC_CONN_AC_UPDATE_P_FLAG			54
> -#define LLC_CONN_AC_DATA_FLAG_SET_2			55
> -#define LLC_CONN_AC_DATA_FLAG_SET_0			56
> -#define LLC_CONN_AC_DATA_FLAG_SET_1			57
> -#define LLC_CONN_AC_DATA_FLAG_SET_1_IF_DATA_FLAG_EQ_0	58
> -#define LLC_CONN_AC_P_FLAG_SET_0			59
> -#define LLC_CONN_AC_P_FLAG_SET_P			60
> -#define LLC_CONN_AC_REMOTE_BUSY_SET_0			61
> -#define LLC_CONN_AC_RETRY_CNT_SET_0			62
> -#define LLC_CONN_AC_RETRY_CNT_INC_BY_1			63
> -#define LLC_CONN_AC_Vr_SET_0				64
> -#define LLC_CONN_AC_Vr_INC_BY_1				65
> -#define LLC_CONN_AC_Vs_SET_0				66
> -#define LLC_CONN_AC_Vs_SET_Nr				67
> -#define LLC_CONN_AC_F_FLAG_SET_P			68
> -#define LLC_CONN_AC_STOP_SENDACK_TMR			70
> -#define LLC_CONN_AC_START_SENDACK_TMR_IF_NOT_RUNNING	71
> -
> -typedef int (*llc_conn_action_t)(struct sock *sk, struct sk_buff *skb);
> -
> -int llc_conn_ac_clear_remote_busy(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_conn_ind(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_conn_confirm(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_data_ind(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_disc_ind(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_rst_ind(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_rst_confirm(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_clear_remote_busy_if_f_eq_1(struct sock *sk,
> -					    struct sk_buff *skb);
> -int llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2(struct sock *sk,
> -					       struct sk_buff *skb);
> -int llc_conn_ac_send_disc_cmd_p_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_dm_rsp_f_set_p(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_dm_rsp_f_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_frmr_rsp_f_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_resend_frmr_rsp_f_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_resend_frmr_rsp_f_set_p(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_i_cmd_p_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_i_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_resend_i_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr(struct sock *sk,
> -						struct sk_buff *skb);
> -int llc_conn_ac_resend_i_rsp_f_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rej_cmd_p_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rej_rsp_f_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rej_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rnr_cmd_p_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rnr_rsp_f_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rnr_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_remote_busy(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_opt_send_rnr_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rr_cmd_p_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rr_rsp_f_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_ack_rsp_f_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_rr_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_ack_xxx_x_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_sabme_cmd_p_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_ua_rsp_f_set_p(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_s_flag_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_s_flag_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_start_p_timer(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_start_ack_timer(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_start_rej_timer(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_start_ack_tmr_if_not_running(struct sock *sk,
> -					     struct sk_buff *skb);
> -int llc_conn_ac_stop_ack_timer(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_stop_p_timer(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_stop_rej_timer(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_stop_all_timers(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_stop_other_timers(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_upd_nr_received(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_inc_tx_win_size(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_dec_tx_win_size(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_upd_p_flag(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_data_flag_2(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_data_flag_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_data_flag_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_data_flag_1_if_data_flag_eq_0(struct sock *sk,
> -						  struct sk_buff *skb);
> -int llc_conn_ac_set_p_flag_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_remote_busy_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_retry_cnt_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_cause_flag_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_cause_flag_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_inc_retry_cnt_by_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_vr_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_inc_vr_by_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_vs_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_set_vs_nr(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_rst_vs(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_upd_vs(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_disc(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_reset(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_disc_confirm(struct sock *sk, struct sk_buff *skb);
> -u8 llc_circular_between(u8 a, u8 b, u8 c);
> -int llc_conn_ac_send_ack_if_needed(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_adjust_npta_by_rr(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_adjust_npta_by_rnr(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_rst_sendack_flag(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ac_send_i_as_ack(struct sock *sk, struct sk_buff *skb);
> -
> -void llc_conn_busy_tmr_cb(struct timer_list *t);
> -void llc_conn_pf_cycle_tmr_cb(struct timer_list *t);
> -void llc_conn_ack_tmr_cb(struct timer_list *t);
> -void llc_conn_rej_tmr_cb(struct timer_list *t);
> -
> -void llc_conn_set_p_flag(struct sock *sk, u8 value);
> -#endif /* LLC_C_AC_H */
> diff --git a/include/net/llc_c_ev.h b/include/net/llc_c_ev.h
> deleted file mode 100644
> index d45140d4289a..000000000000
> --- a/include/net/llc_c_ev.h
> +++ /dev/null
> @@ -1,217 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_C_EV_H
> -#define LLC_C_EV_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - *		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <net/sock.h>
> -
> -/* Connection component state transition event qualifiers */
> -/* Types of events (possible values in 'ev->type') */
> -#define LLC_CONN_EV_TYPE_SIMPLE		 1
> -#define LLC_CONN_EV_TYPE_CONDITION	 2
> -#define LLC_CONN_EV_TYPE_PRIM		 3
> -#define LLC_CONN_EV_TYPE_PDU		 4	/* command/response PDU */
> -#define LLC_CONN_EV_TYPE_ACK_TMR	 5
> -#define LLC_CONN_EV_TYPE_P_TMR		 6
> -#define LLC_CONN_EV_TYPE_REJ_TMR	 7
> -#define LLC_CONN_EV_TYPE_BUSY_TMR	 8
> -#define LLC_CONN_EV_TYPE_RPT_STATUS	 9
> -#define LLC_CONN_EV_TYPE_SENDACK_TMR	10
> -
> -#define NBR_CONN_EV		   5
> -/* Connection events which cause state transitions when fully qualified */
> -
> -#define LLC_CONN_EV_CONN_REQ				 1
> -#define LLC_CONN_EV_CONN_RESP				 2
> -#define LLC_CONN_EV_DATA_REQ				 3
> -#define LLC_CONN_EV_DISC_REQ				 4
> -#define LLC_CONN_EV_RESET_REQ				 5
> -#define LLC_CONN_EV_RESET_RESP				 6
> -#define LLC_CONN_EV_LOCAL_BUSY_DETECTED			 7
> -#define LLC_CONN_EV_LOCAL_BUSY_CLEARED			 8
> -#define LLC_CONN_EV_RX_BAD_PDU				 9
> -#define LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X		10
> -#define LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X		11
> -#define LLC_CONN_EV_RX_FRMR_RSP_Fbit_SET_X		12
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_X			13
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_X_UNEXPD_Ns	14
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_X_INVAL_Ns	15
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_X			16
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_X_UNEXPD_Ns	17
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_X_INVAL_Ns	18
> -#define LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_X		19
> -#define LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_X		20
> -#define LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_X		21
> -#define LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_X		22
> -#define LLC_CONN_EV_RX_RR_CMD_Pbit_SET_X		23
> -#define LLC_CONN_EV_RX_RR_RSP_Fbit_SET_X		24
> -#define LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X		25
> -#define LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X		26
> -#define LLC_CONN_EV_RX_XXX_CMD_Pbit_SET_X		27
> -#define LLC_CONN_EV_RX_XXX_RSP_Fbit_SET_X		28
> -#define LLC_CONN_EV_RX_XXX_YYY				29
> -#define LLC_CONN_EV_RX_ZZZ_CMD_Pbit_SET_X_INVAL_Nr	30
> -#define LLC_CONN_EV_RX_ZZZ_RSP_Fbit_SET_X_INVAL_Nr	31
> -#define LLC_CONN_EV_P_TMR_EXP				32
> -#define LLC_CONN_EV_ACK_TMR_EXP				33
> -#define LLC_CONN_EV_REJ_TMR_EXP				34
> -#define LLC_CONN_EV_BUSY_TMR_EXP			35
> -#define LLC_CONN_EV_RX_XXX_CMD_Pbit_SET_1		36
> -#define LLC_CONN_EV_RX_XXX_CMD_Pbit_SET_0		37
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns	38
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns	39
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_1_UNEXPD_Ns	40
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns	41
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_0			42
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_0			43
> -#define LLC_CONN_EV_RX_I_CMD_Pbit_SET_1			44
> -#define LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0		45
> -#define LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0		46
> -#define LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1		47
> -#define LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1		48
> -#define LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0		49
> -#define LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0		50
> -#define LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1		51
> -#define LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1		52
> -#define LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0		53
> -#define LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0		54
> -#define LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1		55
> -#define LLC_CONN_EV_RX_I_RSP_Fbit_SET_1			56
> -#define LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_1		57
> -#define LLC_CONN_EV_RX_XXX_RSP_Fbit_SET_1		58
> -#define LLC_CONN_EV_TX_BUFF_FULL			59
> -
> -#define LLC_CONN_EV_INIT_P_F_CYCLE			100
> -/*
> - * Connection event qualifiers; for some events a certain combination of
> - * these qualifiers must be TRUE before event recognized valid for state;
> - * these constants act as indexes into the Event Qualifier function
> - * table
> - */
> -#define LLC_CONN_EV_QFY_DATA_FLAG_EQ_1		 1
> -#define LLC_CONN_EV_QFY_DATA_FLAG_EQ_0		 2
> -#define LLC_CONN_EV_QFY_DATA_FLAG_EQ_2		 3
> -#define LLC_CONN_EV_QFY_P_FLAG_EQ_1		 4
> -#define LLC_CONN_EV_QFY_P_FLAG_EQ_0		 5
> -#define LLC_CONN_EV_QFY_P_FLAG_EQ_Fbit		 6
> -#define LLC_CONN_EV_QFY_REMOTE_BUSY_EQ_0	 7
> -#define LLC_CONN_EV_QFY_RETRY_CNT_LT_N2		 8
> -#define LLC_CONN_EV_QFY_RETRY_CNT_GTE_N2	 9
> -#define LLC_CONN_EV_QFY_S_FLAG_EQ_1		10
> -#define LLC_CONN_EV_QFY_S_FLAG_EQ_0		11
> -#define LLC_CONN_EV_QFY_INIT_P_F_CYCLE		12
> -
> -struct llc_conn_state_ev {
> -	u8 type;
> -	u8 prim;
> -	u8 prim_type;
> -	u8 reason;
> -	u8 status;
> -	u8 ind_prim;
> -	u8 cfm_prim;
> -};
> -
> -static __inline__ struct llc_conn_state_ev *llc_conn_ev(struct sk_buff *skb)
> -{
> -	return (struct llc_conn_state_ev *)skb->cb;
> -}
> -
> -typedef int (*llc_conn_ev_t)(struct sock *sk, struct sk_buff *skb);
> -typedef int (*llc_conn_ev_qfyr_t)(struct sock *sk, struct sk_buff *skb);
> -
> -int llc_conn_ev_conn_req(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_data_req(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_disc_req(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rst_req(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_local_busy_detected(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_local_busy_cleared(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_bad_pdu(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_disc_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_dm_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_frmr_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_i_cmd_pbit_set_x_inval_ns(struct sock *sk,
> -					     struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_x_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_x_inval_ns(struct sock *sk,
> -					     struct sk_buff *skb);
> -int llc_conn_ev_rx_rej_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_sabme_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_ua_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_xxx_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_xxx_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_zzz_cmd_pbit_set_x_inval_nr(struct sock *sk,
> -					       struct sk_buff *skb);
> -int llc_conn_ev_rx_zzz_rsp_fbit_set_x_inval_nr(struct sock *sk,
> -					       struct sk_buff *skb);
> -int llc_conn_ev_p_tmr_exp(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_ack_tmr_exp(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rej_tmr_exp(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_busy_tmr_exp(struct sock *sk, struct sk_buff *skb);
> -/* NOT_USED functions and their variations */
> -int llc_conn_ev_rx_xxx_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_xxx_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb);
> -int llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb);
> -int llc_conn_ev_rx_i_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_i_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_i_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rr_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rr_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rr_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rr_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rnr_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rnr_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rnr_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rnr_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rej_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rej_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rej_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_rej_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_rx_any_frame(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_tx_buffer_full(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_init_p_f_cycle(struct sock *sk, struct sk_buff *skb);
> -
> -/* Available connection action qualifiers */
> -int llc_conn_ev_qlfy_data_flag_eq_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_data_flag_eq_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_data_flag_eq_2(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_p_flag_eq_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_last_frame_eq_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_last_frame_eq_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_p_flag_eq_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_p_flag_eq_f(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_remote_busy_eq_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_remote_busy_eq_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_retry_cnt_lt_n2(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_retry_cnt_gte_n2(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_s_flag_eq_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_s_flag_eq_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_cause_flag_eq_1(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_cause_flag_eq_0(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_conn(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_disc(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_failed(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_remote_busy(struct sock *sk,
> -					    struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_refuse(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_conflict(struct sock *sk, struct sk_buff *skb);
> -int llc_conn_ev_qlfy_set_status_rst_done(struct sock *sk, struct sk_buff *skb);
> -
> -static __inline__ int llc_conn_space(struct sock *sk, struct sk_buff *skb)
> -{
> -	return atomic_read(&sk->sk_rmem_alloc) + skb->truesize <
> -	       (unsigned int)sk->sk_rcvbuf;
> -}
> -#endif /* LLC_C_EV_H */
> diff --git a/include/net/llc_c_st.h b/include/net/llc_c_st.h
> deleted file mode 100644
> index f52a4cc4880d..000000000000
> --- a/include/net/llc_c_st.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_C_ST_H
> -#define LLC_C_ST_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - *		2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_ev.h>
> -
> -/* Connection component state management */
> -/* connection states */
> -#define LLC_CONN_OUT_OF_SVC		 0	/* prior to allocation */
> - 
> -#define LLC_CONN_STATE_ADM		 1	/* disc, initial state */
> -#define LLC_CONN_STATE_SETUP		 2	/* disconnected state */
> -#define LLC_CONN_STATE_NORMAL		 3	/* connected state */
> -#define LLC_CONN_STATE_BUSY		 4	/* connected state */
> -#define LLC_CONN_STATE_REJ		 5	/* connected state */
> -#define LLC_CONN_STATE_AWAIT		 6	/* connected state */
> -#define LLC_CONN_STATE_AWAIT_BUSY	 7	/* connected state */
> -#define LLC_CONN_STATE_AWAIT_REJ	 8	/* connected state */
> -#define LLC_CONN_STATE_D_CONN		 9	/* disconnected state */
> -#define LLC_CONN_STATE_RESET		10	/* disconnected state */
> -#define LLC_CONN_STATE_ERROR		11	/* disconnected state */
> -#define LLC_CONN_STATE_TEMP		12	/* disconnected state */
> -
> -#define NBR_CONN_STATES			12	/* size of state table */
> -#define NO_STATE_CHANGE			100
> -
> -/* Connection state table structure */
> -struct llc_conn_state_trans {
> -	llc_conn_ev_t	   ev;
> -	u8		   next_state;
> -	const llc_conn_ev_qfyr_t *ev_qualifiers;
> -	const llc_conn_action_t  *ev_actions;
> -};
> -
> -struct llc_conn_state {
> -	u8				  current_state;
> -	const struct llc_conn_state_trans **transitions;
> -};
> -
> -extern struct llc_conn_state llc_conn_state_table[];
> -#endif /* LLC_C_ST_H */
> diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
> deleted file mode 100644
> index e1a302696723..000000000000
> --- a/include/net/llc_conn.h
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_CONN_H
> -#define LLC_CONN_H
> -/*
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001, 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/timer.h>
> -#include <net/llc_if.h>
> -#include <net/sock.h>
> -#include <linux/llc.h>
> -
> -#define LLC_EVENT                1
> -#define LLC_PACKET               2
> -
> -#define LLC2_P_TIME               2
> -#define LLC2_ACK_TIME             1
> -#define LLC2_REJ_TIME             3
> -#define LLC2_BUSY_TIME            3
> -
> -struct llc_timer {
> -	struct timer_list timer;
> -	unsigned long	  expire;	/* timer expire time */
> -};
> -
> -struct llc_sock {
> -	/* struct sock must be the first member of llc_sock */
> -	struct sock	    sk;
> -	struct sockaddr_llc addr;		/* address sock is bound to */
> -	u8		    state;		/* state of connection */
> -	struct llc_sap	    *sap;		/* pointer to parent SAP */
> -	struct llc_addr	    laddr;		/* lsap/mac pair */
> -	struct llc_addr	    daddr;		/* dsap/mac pair */
> -	struct net_device   *dev;		/* device to send to remote */
> -	netdevice_tracker   dev_tracker;
> -	u32		    copied_seq;		/* head of yet unread data */
> -	u8		    retry_count;	/* number of retries */
> -	u8		    ack_must_be_send;
> -	u8		    first_pdu_Ns;
> -	u8		    npta;
> -	struct llc_timer    ack_timer;
> -	struct llc_timer    pf_cycle_timer;
> -	struct llc_timer    rej_sent_timer;
> -	struct llc_timer    busy_state_timer;	/* ind busy clr at remote LLC */
> -	u8		    vS;			/* seq# next in-seq I-PDU tx'd*/
> -	u8		    vR;			/* seq# next in-seq I-PDU rx'd*/
> -	u32		    n2;			/* max nbr re-tx's for timeout*/
> -	u32		    n1;			/* max nbr octets in I PDU */
> -	u8		    k;			/* tx window size; max = 127 */
> -	u8		    rw;			/* rx window size; max = 127 */
> -	u8		    p_flag;		/* state flags */
> -	u8		    f_flag;
> -	u8		    s_flag;
> -	u8		    data_flag;
> -	u8		    remote_busy_flag;
> -	u8		    cause_flag;
> -	struct sk_buff_head pdu_unack_q;	/* PUDs sent/waiting ack */
> -	u16		    link;		/* network layer link number */
> -	u8		    X;			/* a temporary variable */
> -	u8		    ack_pf;		/* this flag indicates what is
> -						   the P-bit of acknowledge */
> -	u8		    failed_data_req; /* recognize that already exist a
> -						failed llc_data_req_handler
> -						(tx_buffer_full or unacceptable
> -						state */
> -	u8		    dec_step;
> -	u8		    inc_cntr;
> -	u8		    dec_cntr;
> -	u8		    connect_step;
> -	u8		    last_nr;	   /* NR of last pdu received */
> -	u32		    rx_pdu_hdr;	   /* used for saving header of last pdu
> -					      received and caused sending FRMR.
> -					      Used for resending FRMR */
> -	u32		    cmsg_flags;
> -	struct hlist_node   dev_hash_node;
> -};
> -
> -static inline struct llc_sock *llc_sk(const struct sock *sk)
> -{
> -	return (struct llc_sock *)sk;
> -}
> -
> -static __inline__ void llc_set_backlog_type(struct sk_buff *skb, char type)
> -{
> -	skb->cb[sizeof(skb->cb) - 1] = type;
> -}
> -
> -static __inline__ char llc_backlog_type(struct sk_buff *skb)
> -{
> -	return skb->cb[sizeof(skb->cb) - 1];
> -}
> -
> -struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority,
> -			  struct proto *prot, int kern);
> -void llc_sk_stop_all_timers(struct sock *sk, bool sync);
> -void llc_sk_free(struct sock *sk);
> -
> -void llc_sk_reset(struct sock *sk);
> -
> -/* Access to a connection */
> -int llc_conn_state_process(struct sock *sk, struct sk_buff *skb);
> -void llc_conn_send_pdu(struct sock *sk, struct sk_buff *skb);
> -void llc_conn_rtn_pdu(struct sock *sk, struct sk_buff *skb);
> -void llc_conn_resend_i_pdu_as_cmd(struct sock *sk, u8 nr, u8 first_p_bit);
> -void llc_conn_resend_i_pdu_as_rsp(struct sock *sk, u8 nr, u8 first_f_bit);
> -int llc_conn_remove_acked_pdus(struct sock *conn, u8 nr, u16 *how_many_unacked);
> -struct sock *llc_lookup_established(struct llc_sap *sap, struct llc_addr *daddr,
> -				    struct llc_addr *laddr, const struct net *net);
> -void llc_sap_add_socket(struct llc_sap *sap, struct sock *sk);
> -void llc_sap_remove_socket(struct llc_sap *sap, struct sock *sk);
> -
> -u8 llc_data_accept_state(u8 state);
> -void llc_build_offset_table(void);
> -#endif /* LLC_CONN_H */
> diff --git a/include/net/llc_if.h b/include/net/llc_if.h
> deleted file mode 100644
> index a333259613ab..000000000000
> --- a/include/net/llc_if.h
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_IF_H
> -#define LLC_IF_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -/* Defines LLC interface to network layer */
> -/* Available primitives */
> -#include <linux/if.h>
> -#include <linux/if_arp.h>
> -#include <linux/llc.h>
> -#include <linux/etherdevice.h>
> -#include <net/llc.h>
> -
> -#define LLC_DATAUNIT_PRIM	1
> -#define LLC_CONN_PRIM		2
> -#define LLC_DATA_PRIM		3
> -#define LLC_DISC_PRIM		4
> -#define LLC_RESET_PRIM		5
> -#define LLC_FLOWCONTROL_PRIM	6 /* Not supported at this time */
> -#define LLC_DISABLE_PRIM	7
> -#define LLC_XID_PRIM		8
> -#define LLC_TEST_PRIM		9
> -#define LLC_SAP_ACTIVATION     10
> -#define LLC_SAP_DEACTIVATION   11
> -
> -#define LLC_NBR_PRIMITIVES     11
> -
> -#define LLC_IND			1
> -#define LLC_CONFIRM		2
> -
> -/* Primitive type */
> -#define LLC_PRIM_TYPE_REQ	1
> -#define LLC_PRIM_TYPE_IND	2
> -#define LLC_PRIM_TYPE_RESP	3
> -#define LLC_PRIM_TYPE_CONFIRM	4
> -
> -/* Reset reasons, remote entity or local LLC */
> -#define LLC_RESET_REASON_REMOTE	1
> -#define LLC_RESET_REASON_LOCAL	2
> -
> -/* Disconnect reasons */
> -#define LLC_DISC_REASON_RX_DM_RSP_PDU	0
> -#define LLC_DISC_REASON_RX_DISC_CMD_PDU	1
> -#define LLC_DISC_REASON_ACK_TMR_EXP	2
> -
> -/* Confirm reasons */
> -#define LLC_STATUS_CONN		0 /* connect confirm & reset confirm */
> -#define LLC_STATUS_DISC		1 /* connect confirm & reset confirm */
> -#define LLC_STATUS_FAILED	2 /* connect confirm & reset confirm */
> -#define LLC_STATUS_IMPOSSIBLE	3 /* connect confirm */
> -#define LLC_STATUS_RECEIVED	4 /* data conn */
> -#define LLC_STATUS_REMOTE_BUSY	5 /* data conn */
> -#define LLC_STATUS_REFUSE	6 /* data conn */
> -#define LLC_STATUS_CONFLICT	7 /* disconnect conn */
> -#define LLC_STATUS_RESET_DONE	8 /*  */
> -
> -int llc_establish_connection(struct sock *sk, const u8 *lmac, u8 *dmac,
> -			     u8 dsap);
> -int llc_build_and_send_pkt(struct sock *sk, struct sk_buff *skb);
> -int llc_send_disc(struct sock *sk);
> -#endif /* LLC_IF_H */
> diff --git a/include/net/llc_s_ac.h b/include/net/llc_s_ac.h
> deleted file mode 100644
> index 076adc5217fd..000000000000
> --- a/include/net/llc_s_ac.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_S_AC_H
> -#define LLC_S_AC_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -struct llc_sap;
> -struct sk_buff;
> -
> -/* SAP component actions */
> -#define SAP_ACT_UNITDATA_IND	1
> -#define SAP_ACT_SEND_UI		2
> -#define SAP_ACT_SEND_XID_C	3
> -#define SAP_ACT_SEND_XID_R	4
> -#define SAP_ACT_SEND_TEST_C	5
> -#define SAP_ACT_SEND_TEST_R	6
> -#define SAP_ACT_REPORT_STATUS	7
> -#define SAP_ACT_XID_IND		8
> -#define SAP_ACT_TEST_IND	9
> -
> -/* All action functions must look like this */
> -typedef int (*llc_sap_action_t)(struct llc_sap *sap, struct sk_buff *skb);
> -
> -int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_report_status(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_xid_ind(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_action_test_ind(struct llc_sap *sap, struct sk_buff *skb);
> -#endif /* LLC_S_AC_H */
> diff --git a/include/net/llc_s_ev.h b/include/net/llc_s_ev.h
> deleted file mode 100644
> index 7b9c94093336..000000000000
> --- a/include/net/llc_s_ev.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_S_EV_H
> -#define LLC_S_EV_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/skbuff.h>
> -#include <net/llc.h>
> -
> -/* Defines SAP component events */
> -/* Types of events (possible values in 'ev->type') */
> -#define LLC_SAP_EV_TYPE_SIMPLE		1
> -#define LLC_SAP_EV_TYPE_CONDITION	2
> -#define LLC_SAP_EV_TYPE_PRIM		3
> -#define LLC_SAP_EV_TYPE_PDU		4   /* command/response PDU */
> -#define LLC_SAP_EV_TYPE_ACK_TMR		5
> -#define LLC_SAP_EV_TYPE_RPT_STATUS	6
> -
> -#define LLC_SAP_EV_ACTIVATION_REQ	 1
> -#define LLC_SAP_EV_RX_UI		 2
> -#define LLC_SAP_EV_UNITDATA_REQ		 3
> -#define LLC_SAP_EV_XID_REQ		 4
> -#define LLC_SAP_EV_RX_XID_C		 5
> -#define LLC_SAP_EV_RX_XID_R		 6
> -#define LLC_SAP_EV_TEST_REQ		 7
> -#define LLC_SAP_EV_RX_TEST_C		 8
> -#define LLC_SAP_EV_RX_TEST_R		 9
> -#define LLC_SAP_EV_DEACTIVATION_REQ	10
> -
> -struct llc_sap_state_ev {
> -	u8		prim;
> -	u8		prim_type;
> -	u8		type;
> -	u8		reason;
> -	u8		ind_cfm_flag;
> -	struct llc_addr saddr;
> -	struct llc_addr daddr;
> -};
> -
> -static __inline__ struct llc_sap_state_ev *llc_sap_ev(struct sk_buff *skb)
> -{
> -	return (struct llc_sap_state_ev *)skb->cb;
> -}
> -
> -struct llc_sap;
> -
> -typedef int (*llc_sap_ev_t)(struct llc_sap *sap, struct sk_buff *skb);
> -
> -int llc_sap_ev_activation_req(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_rx_ui(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_unitdata_req(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_xid_req(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_rx_xid_c(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_rx_xid_r(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_test_req(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_rx_test_c(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_rx_test_r(struct llc_sap *sap, struct sk_buff *skb);
> -int llc_sap_ev_deactivation_req(struct llc_sap *sap, struct sk_buff *skb);
> -#endif /* LLC_S_EV_H */
> diff --git a/include/net/llc_s_st.h b/include/net/llc_s_st.h
> deleted file mode 100644
> index 85ce230fd946..000000000000
> --- a/include/net/llc_s_st.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_S_ST_H
> -#define LLC_S_ST_H
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/types.h>
> -#include <net/llc_s_ac.h>
> -#include <net/llc_s_ev.h>
> -
> -struct llc_sap_state_trans;
> -
> -#define LLC_NR_SAP_STATES	2       /* size of state table */
> -
> -/* structures and types */
> -/* SAP state table structure */
> -struct llc_sap_state_trans {
> -	llc_sap_ev_t	  ev;
> -	u8		  next_state;
> -	const llc_sap_action_t *ev_actions;
> -};
> -
> -struct llc_sap_state {
> -	u8				 curr_state;
> -	const struct llc_sap_state_trans **transitions;
> -};
> -
> -/* only access to SAP state table */
> -extern struct llc_sap_state llc_sap_state_table[LLC_NR_SAP_STATES];
> -#endif /* LLC_S_ST_H */
> diff --git a/include/net/llc_sap.h b/include/net/llc_sap.h
> deleted file mode 100644
> index b259f5993c46..000000000000
> --- a/include/net/llc_sap.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LLC_SAP_H
> -#define LLC_SAP_H
> -
> -#include <asm/types.h>
> -
> -/*
> - * Copyright (c) 1997 by Procom Technology,Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -struct llc_sap;
> -struct net_device;
> -struct sk_buff;
> -struct sock;
> -
> -void llc_sap_rtn_pdu(struct llc_sap *sap, struct sk_buff *skb);
> -void llc_save_primitive(struct sock *sk, struct sk_buff *skb,
> -			unsigned char prim);
> -struct sk_buff *llc_alloc_frame(struct sock *sk, struct net_device *dev,
> -				u8 type, u32 data_size);
> -
> -void llc_build_and_send_test_pkt(struct llc_sap *sap, struct sk_buff *skb,
> -				 unsigned char *dmac, unsigned char dsap);
> -void llc_build_and_send_xid_pkt(struct llc_sap *sap, struct sk_buff *skb,
> -				unsigned char *dmac, unsigned char dsap);
> -#endif /* LLC_SAP_H */
> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> deleted file mode 100644
> index b0447c33dbf0..000000000000
> --- a/net/llc/af_llc.c
> +++ /dev/null
> @@ -1,1304 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * af_llc.c - LLC User Interface SAPs
> - * Description:
> - *   Functions in this module are implementation of socket based llc
> - *   communications for the Linux operating system. Support of llc class
> - *   one and class two is provided via SOCK_DGRAM and SOCK_STREAM
> - *   respectively.
> - *
> - *   An llc2 connection is (mac + sap), only one llc2 sap connection
> - *   is allowed per mac. Though one sap may have multiple mac + sap
> - *   connections.
> - *
> - * Copyright (c) 2001 by Jay Schulist <jschlst@samba.org>
> - *		 2002-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/compiler.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/rtnetlink.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/sched/signal.h>
> -#include <linux/uio.h>
> -
> -#include <net/llc.h>
> -#include <net/llc_sap.h>
> -#include <net/llc_pdu.h>
> -#include <net/llc_conn.h>
> -#include <net/tcp_states.h>
> -
> -/* remember: uninitialized global data is zeroed because its in .bss */
> -static u16 llc_ui_sap_last_autoport = LLC_SAP_DYN_START;
> -static u16 llc_ui_sap_link_no_max[256];
> -static struct sockaddr_llc llc_ui_addrnull;
> -static const struct proto_ops llc_ui_ops;
> -
> -static bool llc_ui_wait_for_conn(struct sock *sk, long timeout);
> -static int llc_ui_wait_for_disc(struct sock *sk, long timeout);
> -static int llc_ui_wait_for_busy_core(struct sock *sk, long timeout);
> -
> -#if 0
> -#define dprintk(args...) printk(KERN_DEBUG args)
> -#else
> -#define dprintk(args...) do {} while (0)
> -#endif
> -
> -/* Maybe we'll add some more in the future. */
> -#define LLC_CMSG_PKTINFO	1
> -
> -
> -/**
> - *	llc_ui_next_link_no - return the next unused link number for a sap
> - *	@sap: Address of sap to get link number from.
> - *
> - *	Return the next unused link number for a given sap.
> - */
> -static inline u16 llc_ui_next_link_no(int sap)
> -{
> -	return llc_ui_sap_link_no_max[sap]++;
> -}
> -
> -/**
> - *	llc_proto_type - return eth protocol for ARP header type
> - *	@arphrd: ARP header type.
> - *
> - *	Given an ARP header type return the corresponding ethernet protocol.
> - */
> -static inline __be16 llc_proto_type(u16 arphrd)
> -{
> -	return htons(ETH_P_802_2);
> -}
> -
> -/**
> - *	llc_ui_addr_null - determines if a address structure is null
> - *	@addr: Address to test if null.
> - */
> -static inline u8 llc_ui_addr_null(struct sockaddr_llc *addr)
> -{
> -	return !memcmp(addr, &llc_ui_addrnull, sizeof(*addr));
> -}
> -
> -/**
> - *	llc_ui_header_len - return length of llc header based on operation
> - *	@sk: Socket which contains a valid llc socket type.
> - *	@addr: Complete sockaddr_llc structure received from the user.
> - *
> - *	Provide the length of the llc header depending on what kind of
> - *	operation the user would like to perform and the type of socket.
> - *	Returns the correct llc header length.
> - */
> -static inline u8 llc_ui_header_len(struct sock *sk, struct sockaddr_llc *addr)
> -{
> -	u8 rc = LLC_PDU_LEN_U;
> -
> -	if (addr->sllc_test)
> -		rc = LLC_PDU_LEN_U;
> -	else if (addr->sllc_xid)
> -		/* We need to expand header to sizeof(struct llc_xid_info)
> -		 * since llc_pdu_init_as_xid_cmd() sets 4,5,6 bytes of LLC header
> -		 * as XID PDU. In llc_ui_sendmsg() we reserved header size and then
> -		 * filled all other space with user data. If we won't reserve this
> -		 * bytes, llc_pdu_init_as_xid_cmd() will overwrite user data
> -		 */
> -		rc = LLC_PDU_LEN_U_XID;
> -	else if (sk->sk_type == SOCK_STREAM)
> -		rc = LLC_PDU_LEN_I;
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_send_data - send data via reliable llc2 connection
> - *	@sk: Connection the socket is using.
> - *	@skb: Data the user wishes to send.
> - *	@noblock: can we block waiting for data?
> - *
> - *	Send data via reliable llc2 connection.
> - *	Returns 0 upon success, non-zero if action did not succeed.
> - *
> - *	This function always consumes a reference to the skb.
> - */
> -static int llc_ui_send_data(struct sock* sk, struct sk_buff *skb, int noblock)
> -{
> -	struct llc_sock* llc = llc_sk(sk);
> -
> -	if (unlikely(llc_data_accept_state(llc->state) ||
> -		     llc->remote_busy_flag ||
> -		     llc->p_flag)) {
> -		long timeout = sock_sndtimeo(sk, noblock);
> -		int rc;
> -
> -		rc = llc_ui_wait_for_busy_core(sk, timeout);
> -		if (rc) {
> -			kfree_skb(skb);
> -			return rc;
> -		}
> -	}
> -	return llc_build_and_send_pkt(sk, skb);
> -}
> -
> -static void llc_ui_sk_init(struct socket *sock, struct sock *sk)
> -{
> -	sock_graft(sk, sock);
> -	sk->sk_type	= sock->type;
> -	sock->ops	= &llc_ui_ops;
> -}
> -
> -static struct proto llc_proto = {
> -	.name	  = "LLC",
> -	.owner	  = THIS_MODULE,
> -	.obj_size = sizeof(struct llc_sock),
> -	.slab_flags = SLAB_TYPESAFE_BY_RCU,
> -};
> -
> -/**
> - *	llc_ui_create - alloc and init a new llc_ui socket
> - *	@net: network namespace (must be default network)
> - *	@sock: Socket to initialize and attach allocated sk to.
> - *	@protocol: Unused.
> - *	@kern: on behalf of kernel or userspace
> - *
> - *	Allocate and initialize a new llc_ui socket, validate the user wants a
> - *	socket type we have available.
> - *	Returns 0 upon success, negative upon failure.
> - */
> -static int llc_ui_create(struct net *net, struct socket *sock, int protocol,
> -			 int kern)
> -{
> -	struct sock *sk;
> -	int rc = -ESOCKTNOSUPPORT;
> -
> -	if (!ns_capable(net->user_ns, CAP_NET_RAW))
> -		return -EPERM;
> -
> -	if (!net_eq(net, &init_net))
> -		return -EAFNOSUPPORT;
> -
> -	if (likely(sock->type == SOCK_DGRAM || sock->type == SOCK_STREAM)) {
> -		rc = -ENOMEM;
> -		sk = llc_sk_alloc(net, PF_LLC, GFP_KERNEL, &llc_proto, kern);
> -		if (sk) {
> -			rc = 0;
> -			llc_ui_sk_init(sock, sk);
> -		}
> -	}
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_release - shutdown socket
> - *	@sock: Socket to release.
> - *
> - *	Shutdown and deallocate an existing socket.
> - */
> -static int llc_ui_release(struct socket *sock)
> -{
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc;
> -
> -	if (unlikely(sk == NULL))
> -		goto out;
> -	sock_hold(sk);
> -	lock_sock(sk);
> -	llc = llc_sk(sk);
> -	dprintk("%s: closing local(%02X) remote(%02X)\n", __func__,
> -		llc->laddr.lsap, llc->daddr.lsap);
> -	if (!llc_send_disc(sk))
> -		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
> -	if (!sock_flag(sk, SOCK_ZAPPED)) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		/* Hold this for release_sock(), so that llc_backlog_rcv()
> -		 * could still use it.
> -		 */
> -		llc_sap_hold(sap);
> -		llc_sap_remove_socket(llc->sap, sk);
> -		release_sock(sk);
> -		llc_sap_put(sap);
> -	} else {
> -		release_sock(sk);
> -	}
> -	netdev_put(llc->dev, &llc->dev_tracker);
> -	sock_put(sk);
> -	sock_orphan(sk);
> -	sock->sk = NULL;
> -	llc_sk_free(sk);
> -out:
> -	return 0;
> -}
> -
> -/**
> - *	llc_ui_autoport - provide dynamically allocate SAP number
> - *
> - *	Provide the caller with a dynamically allocated SAP number according
> - *	to the rules that are set in this function. Returns: 0, upon failure,
> - *	SAP number otherwise.
> - */
> -static int llc_ui_autoport(void)
> -{
> -	struct llc_sap *sap;
> -	int i, tries = 0;
> -
> -	while (tries < LLC_SAP_DYN_TRIES) {
> -		for (i = llc_ui_sap_last_autoport;
> -		     i < LLC_SAP_DYN_STOP; i += 2) {
> -			sap = llc_sap_find(i);
> -			if (!sap) {
> -				llc_ui_sap_last_autoport = i + 2;
> -				goto out;
> -			}
> -			llc_sap_put(sap);
> -		}
> -		llc_ui_sap_last_autoport = LLC_SAP_DYN_START;
> -		tries++;
> -	}
> -	i = 0;
> -out:
> -	return i;
> -}
> -
> -/**
> - *	llc_ui_autobind - automatically bind a socket to a sap
> - *	@sock: socket to bind
> - *	@addr: address to connect to
> - *
> - * 	Used by llc_ui_connect and llc_ui_sendmsg when the user hasn't
> - * 	specifically used llc_ui_bind to bind to an specific address/sap
> - *
> - *	Returns: 0 upon success, negative otherwise.
> - */
> -static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
> -{
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct net_device *dev = NULL;
> -	struct llc_sap *sap;
> -	int rc = -EINVAL;
> -
> -	if (!sock_flag(sk, SOCK_ZAPPED))
> -		goto out;
> -	if (!addr->sllc_arphrd)
> -		addr->sllc_arphrd = ARPHRD_ETHER;
> -	if (addr->sllc_arphrd != ARPHRD_ETHER)
> -		goto out;
> -	rc = -ENODEV;
> -	if (sk->sk_bound_dev_if) {
> -		dev = dev_get_by_index(&init_net, sk->sk_bound_dev_if);
> -		if (dev && addr->sllc_arphrd != dev->type) {
> -			dev_put(dev);
> -			dev = NULL;
> -		}
> -	} else
> -		dev = dev_getfirstbyhwtype(&init_net, addr->sllc_arphrd);
> -	if (!dev)
> -		goto out;
> -	rc = -EUSERS;
> -	llc->laddr.lsap = llc_ui_autoport();
> -	if (!llc->laddr.lsap)
> -		goto out;
> -	rc = -EBUSY; /* some other network layer is using the sap */
> -	sap = llc_sap_open(llc->laddr.lsap, NULL);
> -	if (!sap)
> -		goto out;
> -
> -	/* Note: We do not expect errors from this point. */
> -	llc->dev = dev;
> -	netdev_tracker_alloc(llc->dev, &llc->dev_tracker, GFP_KERNEL);
> -	dev = NULL;
> -
> -	memcpy(llc->laddr.mac, llc->dev->dev_addr, IFHWADDRLEN);
> -	memcpy(&llc->addr, addr, sizeof(llc->addr));
> -	/* assign new connection to its SAP */
> -	llc_sap_add_socket(sap, sk);
> -	sock_reset_flag(sk, SOCK_ZAPPED);
> -	llc_sap_put(sap);
> -	rc = 0;
> -out:
> -	dev_put(dev);
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_bind - bind a socket to a specific address.
> - *	@sock: Socket to bind an address to.
> - *	@uaddr: Address the user wants the socket bound to.
> - *	@addrlen: Length of the uaddr structure.
> - *
> - *	Bind a socket to a specific address. For llc a user is able to bind to
> - *	a specific sap only or mac + sap.
> - *	If the user desires to bind to a specific mac + sap, it is possible to
> - *	have multiple sap connections via multiple macs.
> - *	Bind and autobind for that matter must enforce the correct sap usage
> - *	otherwise all hell will break loose.
> - *	Returns: 0 upon success, negative otherwise.
> - */
> -static int llc_ui_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addrlen)
> -{
> -	struct sockaddr_llc *addr = (struct sockaddr_llc *)uaddr;
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct net_device *dev = NULL;
> -	struct llc_sap *sap;
> -	int rc = -EINVAL;
> -
> -	lock_sock(sk);
> -	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen != sizeof(*addr)))
> -		goto out;
> -	rc = -EAFNOSUPPORT;
> -	if (!addr->sllc_arphrd)
> -		addr->sllc_arphrd = ARPHRD_ETHER;
> -	if (unlikely(addr->sllc_family != AF_LLC || addr->sllc_arphrd != ARPHRD_ETHER))
> -		goto out;
> -	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
> -	rc = -ENODEV;
> -	rcu_read_lock();
> -	if (sk->sk_bound_dev_if) {
> -		dev = dev_get_by_index_rcu(&init_net, sk->sk_bound_dev_if);
> -		if (dev) {
> -			if (is_zero_ether_addr(addr->sllc_mac))
> -				memcpy(addr->sllc_mac, dev->dev_addr,
> -				       IFHWADDRLEN);
> -			if (addr->sllc_arphrd != dev->type ||
> -			    !ether_addr_equal(addr->sllc_mac,
> -					      dev->dev_addr)) {
> -				rc = -EINVAL;
> -				dev = NULL;
> -			}
> -		}
> -	} else {
> -		dev = dev_getbyhwaddr_rcu(&init_net, addr->sllc_arphrd,
> -					   addr->sllc_mac);
> -	}
> -	dev_hold(dev);
> -	rcu_read_unlock();
> -	if (!dev)
> -		goto out;
> -
> -	if (!addr->sllc_sap) {
> -		rc = -EUSERS;
> -		addr->sllc_sap = llc_ui_autoport();
> -		if (!addr->sllc_sap)
> -			goto out;
> -	}
> -	sap = llc_sap_find(addr->sllc_sap);
> -	if (!sap) {
> -		sap = llc_sap_open(addr->sllc_sap, NULL);
> -		rc = -EBUSY; /* some other network layer is using the sap */
> -		if (!sap)
> -			goto out;
> -	} else {
> -		struct llc_addr laddr, daddr;
> -		struct sock *ask;
> -
> -		memset(&laddr, 0, sizeof(laddr));
> -		memset(&daddr, 0, sizeof(daddr));
> -		/*
> -		 * FIXME: check if the address is multicast,
> -		 * 	  only SOCK_DGRAM can do this.
> -		 */
> -		memcpy(laddr.mac, addr->sllc_mac, IFHWADDRLEN);
> -		laddr.lsap = addr->sllc_sap;
> -		rc = -EADDRINUSE; /* mac + sap clash. */
> -		ask = llc_lookup_established(sap, &daddr, &laddr, &init_net);
> -		if (ask) {
> -			sock_put(ask);
> -			goto out_put;
> -		}
> -	}
> -
> -	/* Note: We do not expect errors from this point. */
> -	llc->dev = dev;
> -	netdev_tracker_alloc(llc->dev, &llc->dev_tracker, GFP_KERNEL);
> -	dev = NULL;
> -
> -	llc->laddr.lsap = addr->sllc_sap;
> -	memcpy(llc->laddr.mac, addr->sllc_mac, IFHWADDRLEN);
> -	memcpy(&llc->addr, addr, sizeof(llc->addr));
> -	/* assign new connection to its SAP */
> -	llc_sap_add_socket(sap, sk);
> -	sock_reset_flag(sk, SOCK_ZAPPED);
> -	rc = 0;
> -out_put:
> -	llc_sap_put(sap);
> -out:
> -	dev_put(dev);
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_shutdown - shutdown a connect llc2 socket.
> - *	@sock: Socket to shutdown.
> - *	@how: What part of the socket to shutdown.
> - *
> - *	Shutdown a connected llc2 socket. Currently this function only supports
> - *	shutting down both sends and receives (2), we could probably make this
> - *	function such that a user can shutdown only half the connection but not
> - *	right now.
> - *	Returns: 0 upon success, negative otherwise.
> - */
> -static int llc_ui_shutdown(struct socket *sock, int how)
> -{
> -	struct sock *sk = sock->sk;
> -	int rc = -ENOTCONN;
> -
> -	lock_sock(sk);
> -	if (unlikely(sk->sk_state != TCP_ESTABLISHED))
> -		goto out;
> -	rc = -EINVAL;
> -	if (how != 2)
> -		goto out;
> -	rc = llc_send_disc(sk);
> -	if (!rc)
> -		rc = llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
> -	/* Wake up anyone sleeping in poll */
> -	sk->sk_state_change(sk);
> -out:
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_connect - Connect to a remote llc2 mac + sap.
> - *	@sock: Socket which will be connected to the remote destination.
> - *	@uaddr: Remote and possibly the local address of the new connection.
> - *	@addrlen: Size of uaddr structure.
> - *	@flags: Operational flags specified by the user.
> - *
> - *	Connect to a remote llc2 mac + sap. The caller must specify the
> - *	destination mac and address to connect to. If the user hasn't previously
> - *	called bind(2) with a smac the address of the first interface of the
> - *	specified arp type will be used.
> - *	This function will autobind if user did not previously call bind.
> - *	Returns: 0 upon success, negative otherwise.
> - */
> -static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
> -			  int addrlen, int flags)
> -{
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sockaddr_llc *addr = (struct sockaddr_llc *)uaddr;
> -	int rc = -EINVAL;
> -
> -	lock_sock(sk);
> -	if (unlikely(addrlen != sizeof(*addr)))
> -		goto out;
> -	rc = -EAFNOSUPPORT;
> -	if (unlikely(addr->sllc_family != AF_LLC))
> -		goto out;
> -	if (unlikely(sk->sk_type != SOCK_STREAM))
> -		goto out;
> -	rc = -EALREADY;
> -	if (unlikely(sock->state == SS_CONNECTING))
> -		goto out;
> -	/* bind connection to sap if user hasn't done it. */
> -	if (sock_flag(sk, SOCK_ZAPPED)) {
> -		/* bind to sap with null dev, exclusive */
> -		rc = llc_ui_autobind(sock, addr);
> -		if (rc)
> -			goto out;
> -	}
> -	llc->daddr.lsap = addr->sllc_sap;
> -	memcpy(llc->daddr.mac, addr->sllc_mac, IFHWADDRLEN);
> -	sock->state = SS_CONNECTING;
> -	sk->sk_state   = TCP_SYN_SENT;
> -	llc->link   = llc_ui_next_link_no(llc->sap->laddr.lsap);
> -	rc = llc_establish_connection(sk, llc->dev->dev_addr,
> -				      addr->sllc_mac, addr->sllc_sap);
> -	if (rc) {
> -		dprintk("%s: llc_ui_send_conn failed :-(\n", __func__);
> -		sock->state  = SS_UNCONNECTED;
> -		sk->sk_state = TCP_CLOSE;
> -		goto out;
> -	}
> -
> -	if (sk->sk_state == TCP_SYN_SENT) {
> -		const long timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
> -
> -		if (!timeo || !llc_ui_wait_for_conn(sk, timeo)) {
> -			rc = -EINPROGRESS;
> -			goto out;
> -		}
> -
> -		rc = sock_intr_errno(timeo);
> -		if (signal_pending(current))
> -			goto out;
> -	}
> -
> -	if (sk->sk_state == TCP_CLOSE)
> -		goto sock_error;
> -
> -	sock->state = SS_CONNECTED;
> -	rc = 0;
> -out:
> -	release_sock(sk);
> -	return rc;
> -sock_error:
> -	rc = sock_error(sk) ? : -ECONNABORTED;
> -	sock->state = SS_UNCONNECTED;
> -	goto out;
> -}
> -
> -/**
> - *	llc_ui_listen - allow a normal socket to accept incoming connections
> - *	@sock: Socket to allow incoming connections on.
> - *	@backlog: Number of connections to queue.
> - *
> - *	Allow a normal socket to accept incoming connections.
> - *	Returns 0 upon success, negative otherwise.
> - */
> -static int llc_ui_listen(struct socket *sock, int backlog)
> -{
> -	struct sock *sk = sock->sk;
> -	int rc = -EINVAL;
> -
> -	lock_sock(sk);
> -	if (unlikely(sock->state != SS_UNCONNECTED))
> -		goto out;
> -	rc = -EOPNOTSUPP;
> -	if (unlikely(sk->sk_type != SOCK_STREAM))
> -		goto out;
> -	rc = -EAGAIN;
> -	if (sock_flag(sk, SOCK_ZAPPED))
> -		goto out;
> -	rc = 0;
> -	if (!(unsigned int)backlog)	/* BSDism */
> -		backlog = 1;
> -	sk->sk_max_ack_backlog = backlog;
> -	if (sk->sk_state != TCP_LISTEN) {
> -		sk->sk_ack_backlog = 0;
> -		sk->sk_state	   = TCP_LISTEN;
> -	}
> -	sk->sk_socket->flags |= __SO_ACCEPTCON;
> -out:
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -static int llc_ui_wait_for_disc(struct sock *sk, long timeout)
> -{
> -	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -	int rc = 0;
> -
> -	add_wait_queue(sk_sleep(sk), &wait);
> -	while (1) {
> -		if (sk_wait_event(sk, &timeout,
> -				  READ_ONCE(sk->sk_state) == TCP_CLOSE, &wait))
> -			break;
> -		rc = -ERESTARTSYS;
> -		if (signal_pending(current))
> -			break;
> -		rc = -EAGAIN;
> -		if (!timeout)
> -			break;
> -		rc = 0;
> -	}
> -	remove_wait_queue(sk_sleep(sk), &wait);
> -	return rc;
> -}
> -
> -static bool llc_ui_wait_for_conn(struct sock *sk, long timeout)
> -{
> -	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -
> -	add_wait_queue(sk_sleep(sk), &wait);
> -	while (1) {
> -		if (sk_wait_event(sk, &timeout,
> -				  READ_ONCE(sk->sk_state) != TCP_SYN_SENT, &wait))
> -			break;
> -		if (signal_pending(current) || !timeout)
> -			break;
> -	}
> -	remove_wait_queue(sk_sleep(sk), &wait);
> -	return timeout;
> -}
> -
> -static int llc_ui_wait_for_busy_core(struct sock *sk, long timeout)
> -{
> -	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -	struct llc_sock *llc = llc_sk(sk);
> -	int rc;
> -
> -	add_wait_queue(sk_sleep(sk), &wait);
> -	while (1) {
> -		rc = 0;
> -		if (sk_wait_event(sk, &timeout,
> -				  (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
> -				  (!llc_data_accept_state(llc->state) &&
> -				   !llc->remote_busy_flag &&
> -				   !llc->p_flag), &wait))
> -			break;
> -		rc = -ERESTARTSYS;
> -		if (signal_pending(current))
> -			break;
> -		rc = -EAGAIN;
> -		if (!timeout)
> -			break;
> -	}
> -	remove_wait_queue(sk_sleep(sk), &wait);
> -	return rc;
> -}
> -
> -static int llc_wait_data(struct sock *sk, long timeo)
> -{
> -	int rc;
> -
> -	while (1) {
> -		/*
> -		 * POSIX 1003.1g mandates this order.
> -		 */
> -		rc = sock_error(sk);
> -		if (rc)
> -			break;
> -		rc = 0;
> -		if (sk->sk_shutdown & RCV_SHUTDOWN)
> -			break;
> -		rc = -EAGAIN;
> -		if (!timeo)
> -			break;
> -		rc = sock_intr_errno(timeo);
> -		if (signal_pending(current))
> -			break;
> -		rc = 0;
> -		if (sk_wait_data(sk, &timeo, NULL))
> -			break;
> -	}
> -	return rc;
> -}
> -
> -static void llc_cmsg_rcv(struct msghdr *msg, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(skb->sk);
> -
> -	if (llc->cmsg_flags & LLC_CMSG_PKTINFO) {
> -		struct llc_pktinfo info;
> -
> -		memset(&info, 0, sizeof(info));
> -		info.lpi_ifindex = llc_sk(skb->sk)->dev->ifindex;
> -		llc_pdu_decode_dsap(skb, &info.lpi_sap);
> -		llc_pdu_decode_da(skb, info.lpi_mac);
> -		put_cmsg(msg, SOL_LLC, LLC_OPT_PKTINFO, sizeof(info), &info);
> -	}
> -}
> -
> -/**
> - *	llc_ui_accept - accept a new incoming connection.
> - *	@sock: Socket which connections arrive on.
> - *	@newsock: Socket to move incoming connection to.
> - *	@arg: User specified arguments
> - *
> - *	Accept a new incoming connection.
> - *	Returns 0 upon success, negative otherwise.
> - */
> -static int llc_ui_accept(struct socket *sock, struct socket *newsock,
> -			 struct proto_accept_arg *arg)
> -{
> -	struct sock *sk = sock->sk, *newsk;
> -	struct llc_sock *llc, *newllc;
> -	struct sk_buff *skb;
> -	int rc = -EOPNOTSUPP;
> -
> -	dprintk("%s: accepting on %02X\n", __func__,
> -		llc_sk(sk)->laddr.lsap);
> -	lock_sock(sk);
> -	if (unlikely(sk->sk_type != SOCK_STREAM))
> -		goto out;
> -	rc = -EINVAL;
> -	if (unlikely(sock->state != SS_UNCONNECTED ||
> -		     sk->sk_state != TCP_LISTEN))
> -		goto out;
> -	/* wait for a connection to arrive. */
> -	if (skb_queue_empty(&sk->sk_receive_queue)) {
> -		rc = llc_wait_data(sk, READ_ONCE(sk->sk_rcvtimeo));
> -		if (rc)
> -			goto out;
> -	}
> -	dprintk("%s: got a new connection on %02X\n", __func__,
> -		llc_sk(sk)->laddr.lsap);
> -	skb = skb_dequeue(&sk->sk_receive_queue);
> -	rc = -EINVAL;
> -	if (!skb->sk)
> -		goto frees;
> -	rc = 0;
> -	newsk = skb->sk;
> -	/* attach connection to a new socket. */
> -	llc_ui_sk_init(newsock, newsk);
> -	sock_reset_flag(newsk, SOCK_ZAPPED);
> -	newsk->sk_state		= TCP_ESTABLISHED;
> -	newsock->state		= SS_CONNECTED;
> -	llc			= llc_sk(sk);
> -	newllc			= llc_sk(newsk);
> -	memcpy(&newllc->addr, &llc->addr, sizeof(newllc->addr));
> -	newllc->link = llc_ui_next_link_no(newllc->laddr.lsap);
> -
> -	/* put original socket back into a clean listen state. */
> -	sk->sk_state = TCP_LISTEN;
> -	sk_acceptq_removed(sk);
> -	dprintk("%s: ok success on %02X, client on %02X\n", __func__,
> -		llc_sk(sk)->addr.sllc_sap, newllc->daddr.lsap);
> -frees:
> -	kfree_skb(skb);
> -out:
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_recvmsg - copy received data to the socket user.
> - *	@sock: Socket to copy data from.
> - *	@msg: Various user space related information.
> - *	@len: Size of user buffer.
> - *	@flags: User specified flags.
> - *
> - *	Copy received data to the socket user.
> - *	Returns non-negative upon success, negative otherwise.
> - */
> -static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> -			  int flags)
> -{
> -	DECLARE_SOCKADDR(struct sockaddr_llc *, uaddr, msg->msg_name);
> -	const int nonblock = flags & MSG_DONTWAIT;
> -	struct sk_buff *skb = NULL;
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	size_t copied = 0;
> -	u32 peek_seq = 0;
> -	u32 *seq, skb_len;
> -	unsigned long used;
> -	int target;	/* Read at least this many bytes */
> -	long timeo;
> -
> -	lock_sock(sk);
> -	copied = -ENOTCONN;
> -	if (unlikely(sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_LISTEN))
> -		goto out;
> -
> -	timeo = sock_rcvtimeo(sk, nonblock);
> -
> -	seq = &llc->copied_seq;
> -	if (flags & MSG_PEEK) {
> -		peek_seq = llc->copied_seq;
> -		seq = &peek_seq;
> -	}
> -
> -	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
> -	copied = 0;
> -
> -	do {
> -		u32 offset;
> -
> -		/*
> -		 * We need to check signals first, to get correct SIGURG
> -		 * handling. FIXME: Need to check this doesn't impact 1003.1g
> -		 * and move it down to the bottom of the loop
> -		 */
> -		if (signal_pending(current)) {
> -			if (copied)
> -				break;
> -			copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
> -			break;
> -		}
> -
> -		/* Next get a buffer. */
> -
> -		skb = skb_peek(&sk->sk_receive_queue);
> -		if (skb) {
> -			offset = *seq;
> -			goto found_ok_skb;
> -		}
> -		/* Well, if we have backlog, try to process it now yet. */
> -
> -		if (copied >= target && !READ_ONCE(sk->sk_backlog.tail))
> -			break;
> -
> -		if (copied) {
> -			if (sk->sk_err ||
> -			    sk->sk_state == TCP_CLOSE ||
> -			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> -			    !timeo ||
> -			    (flags & MSG_PEEK))
> -				break;
> -		} else {
> -			if (sock_flag(sk, SOCK_DONE))
> -				break;
> -
> -			if (sk->sk_err) {
> -				copied = sock_error(sk);
> -				break;
> -			}
> -			if (sk->sk_shutdown & RCV_SHUTDOWN)
> -				break;
> -
> -			if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSE) {
> -				if (!sock_flag(sk, SOCK_DONE)) {
> -					/*
> -					 * This occurs when user tries to read
> -					 * from never connected socket.
> -					 */
> -					copied = -ENOTCONN;
> -					break;
> -				}
> -				break;
> -			}
> -			if (!timeo) {
> -				copied = -EAGAIN;
> -				break;
> -			}
> -		}
> -
> -		if (copied >= target) { /* Do not sleep, just process backlog. */
> -			release_sock(sk);
> -			lock_sock(sk);
> -		} else
> -			sk_wait_data(sk, &timeo, NULL);
> -
> -		if ((flags & MSG_PEEK) && peek_seq != llc->copied_seq) {
> -			net_dbg_ratelimited("LLC(%s:%d): Application bug, race in MSG_PEEK\n",
> -					    current->comm,
> -					    task_pid_nr(current));
> -			peek_seq = llc->copied_seq;
> -		}
> -		continue;
> -	found_ok_skb:
> -		skb_len = skb->len;
> -		/* Ok so how much can we use? */
> -		used = skb->len - offset;
> -		if (len < used)
> -			used = len;
> -
> -		if (!(flags & MSG_TRUNC)) {
> -			int rc = skb_copy_datagram_msg(skb, offset, msg, used);
> -			if (rc) {
> -				/* Exception. Bailout! */
> -				if (!copied)
> -					copied = -EFAULT;
> -				break;
> -			}
> -		}
> -
> -		*seq += used;
> -		copied += used;
> -		len -= used;
> -
> -		/* For non stream protcols we get one packet per recvmsg call */
> -		if (sk->sk_type != SOCK_STREAM)
> -			goto copy_uaddr;
> -
> -		/* Partial read */
> -		if (used + offset < skb_len)
> -			continue;
> -
> -		if (!(flags & MSG_PEEK)) {
> -			skb_unlink(skb, &sk->sk_receive_queue);
> -			kfree_skb(skb);
> -			*seq = 0;
> -		}
> -	} while (len > 0);
> -
> -out:
> -	release_sock(sk);
> -	return copied;
> -copy_uaddr:
> -	if (uaddr != NULL && skb != NULL) {
> -		memcpy(uaddr, llc_ui_skb_cb(skb), sizeof(*uaddr));
> -		msg->msg_namelen = sizeof(*uaddr);
> -	}
> -	if (llc_sk(sk)->cmsg_flags)
> -		llc_cmsg_rcv(msg, skb);
> -
> -	if (!(flags & MSG_PEEK)) {
> -		skb_unlink(skb, &sk->sk_receive_queue);
> -		kfree_skb(skb);
> -		*seq = 0;
> -	}
> -
> -	goto out;
> -}
> -
> -/**
> - *	llc_ui_sendmsg - Transmit data provided by the socket user.
> - *	@sock: Socket to transmit data from.
> - *	@msg: Various user related information.
> - *	@len: Length of data to transmit.
> - *
> - *	Transmit data provided by the socket user.
> - *	Returns non-negative upon success, negative otherwise.
> - */
> -static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> -{
> -	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	int flags = msg->msg_flags;
> -	int noblock = flags & MSG_DONTWAIT;
> -	int rc = -EINVAL, copied = 0, hdrlen, hh_len;
> -	struct sk_buff *skb = NULL;
> -	struct net_device *dev;
> -	size_t size = 0;
> -
> -	dprintk("%s: sending from %02X to %02X\n", __func__,
> -		llc->laddr.lsap, llc->daddr.lsap);
> -	lock_sock(sk);
> -	if (addr) {
> -		if (msg->msg_namelen < sizeof(*addr))
> -			goto out;
> -	} else {
> -		if (llc_ui_addr_null(&llc->addr))
> -			goto out;
> -		addr = &llc->addr;
> -	}
> -	/* must bind connection to sap if user hasn't done it. */
> -	if (sock_flag(sk, SOCK_ZAPPED)) {
> -		/* bind to sap with null dev, exclusive. */
> -		rc = llc_ui_autobind(sock, addr);
> -		if (rc)
> -			goto out;
> -	}
> -	dev = llc->dev;
> -	hh_len = LL_RESERVED_SPACE(dev);
> -	hdrlen = llc_ui_header_len(sk, addr);
> -	size = hdrlen + len;
> -	size = min_t(size_t, size, READ_ONCE(dev->mtu));
> -	copied = size - hdrlen;
> -	rc = -EINVAL;
> -	if (copied < 0)
> -		goto out;
> -	release_sock(sk);
> -	skb = sock_alloc_send_skb(sk, hh_len + size, noblock, &rc);
> -	lock_sock(sk);
> -	if (!skb)
> -		goto out;
> -	if (sock_flag(sk, SOCK_ZAPPED) ||
> -	    llc->dev != dev ||
> -	    hdrlen != llc_ui_header_len(sk, addr) ||
> -	    hh_len != LL_RESERVED_SPACE(dev) ||
> -	    size > READ_ONCE(dev->mtu))
> -		goto out;
> -	skb->dev      = dev;
> -	skb->protocol = llc_proto_type(addr->sllc_arphrd);
> -	skb_reserve(skb, hh_len + hdrlen);
> -	rc = memcpy_from_msg(skb_put(skb, copied), msg, copied);
> -	if (rc)
> -		goto out;
> -	if (sk->sk_type == SOCK_DGRAM || addr->sllc_ua) {
> -		llc_build_and_send_ui_pkt(llc->sap, skb, addr->sllc_mac,
> -					  addr->sllc_sap);
> -		skb = NULL;
> -		goto out;
> -	}
> -	if (addr->sllc_test) {
> -		llc_build_and_send_test_pkt(llc->sap, skb, addr->sllc_mac,
> -					    addr->sllc_sap);
> -		skb = NULL;
> -		goto out;
> -	}
> -	if (addr->sllc_xid) {
> -		llc_build_and_send_xid_pkt(llc->sap, skb, addr->sllc_mac,
> -					   addr->sllc_sap);
> -		skb = NULL;
> -		goto out;
> -	}
> -	rc = -ENOPROTOOPT;
> -	if (!(sk->sk_type == SOCK_STREAM && !addr->sllc_ua))
> -		goto out;
> -	rc = llc_ui_send_data(sk, skb, noblock);
> -	skb = NULL;
> -out:
> -	kfree_skb(skb);
> -	if (rc)
> -		dprintk("%s: failed sending from %02X to %02X: %d\n",
> -			__func__, llc->laddr.lsap, llc->daddr.lsap, rc);
> -	release_sock(sk);
> -	return rc ? : copied;
> -}
> -
> -/**
> - *	llc_ui_getname - return the address info of a socket
> - *	@sock: Socket to get address of.
> - *	@uaddr: Address structure to return information.
> - *	@peer: Does user want local or remote address information.
> - *
> - *	Return the address information of a socket.
> - */
> -static int llc_ui_getname(struct socket *sock, struct sockaddr *uaddr,
> -			  int peer)
> -{
> -	struct sockaddr_llc sllc;
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	int rc = -EBADF;
> -
> -	memset(&sllc, 0, sizeof(sllc));
> -	lock_sock(sk);
> -	if (sock_flag(sk, SOCK_ZAPPED))
> -		goto out;
> -	if (peer) {
> -		rc = -ENOTCONN;
> -		if (sk->sk_state != TCP_ESTABLISHED)
> -			goto out;
> -		if(llc->dev)
> -			sllc.sllc_arphrd = llc->dev->type;
> -		sllc.sllc_sap = llc->daddr.lsap;
> -		memcpy(&sllc.sllc_mac, &llc->daddr.mac, IFHWADDRLEN);
> -	} else {
> -		rc = -EINVAL;
> -		if (!llc->sap)
> -			goto out;
> -		sllc.sllc_sap = llc->sap->laddr.lsap;
> -
> -		if (llc->dev) {
> -			sllc.sllc_arphrd = llc->dev->type;
> -			memcpy(&sllc.sllc_mac, llc->dev->dev_addr,
> -			       IFHWADDRLEN);
> -		}
> -	}
> -	sllc.sllc_family = AF_LLC;
> -	memcpy(uaddr, &sllc, sizeof(sllc));
> -	rc = sizeof(sllc);
> -out:
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_ioctl - io controls for PF_LLC
> - *	@sock: Socket to get/set info
> - *	@cmd: command
> - *	@arg: optional argument for cmd
> - *
> - *	get/set info on llc sockets
> - */
> -static int llc_ui_ioctl(struct socket *sock, unsigned int cmd,
> -			unsigned long arg)
> -{
> -	return -ENOIOCTLCMD;
> -}
> -
> -/**
> - *	llc_ui_setsockopt - set various connection specific parameters.
> - *	@sock: Socket to set options on.
> - *	@level: Socket level user is requesting operations on.
> - *	@optname: Operation name.
> - *	@optval: User provided operation data.
> - *	@optlen: Length of optval.
> - *
> - *	Set various connection specific parameters.
> - */
> -static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
> -			     sockptr_t optval, unsigned int optlen)
> -{
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	unsigned int opt;
> -	int rc = -EINVAL;
> -
> -	lock_sock(sk);
> -	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
> -		goto out;
> -	rc = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> -	if (rc)
> -		goto out;
> -	rc = -EINVAL;
> -	switch (optname) {
> -	case LLC_OPT_RETRY:
> -		if (opt > LLC_OPT_MAX_RETRY)
> -			goto out;
> -		llc->n2 = opt;
> -		break;
> -	case LLC_OPT_SIZE:
> -		if (opt > LLC_OPT_MAX_SIZE)
> -			goto out;
> -		llc->n1 = opt;
> -		break;
> -	case LLC_OPT_ACK_TMR_EXP:
> -		if (opt > LLC_OPT_MAX_ACK_TMR_EXP)
> -			goto out;
> -		llc->ack_timer.expire = opt * HZ;
> -		break;
> -	case LLC_OPT_P_TMR_EXP:
> -		if (opt > LLC_OPT_MAX_P_TMR_EXP)
> -			goto out;
> -		llc->pf_cycle_timer.expire = opt * HZ;
> -		break;
> -	case LLC_OPT_REJ_TMR_EXP:
> -		if (opt > LLC_OPT_MAX_REJ_TMR_EXP)
> -			goto out;
> -		llc->rej_sent_timer.expire = opt * HZ;
> -		break;
> -	case LLC_OPT_BUSY_TMR_EXP:
> -		if (opt > LLC_OPT_MAX_BUSY_TMR_EXP)
> -			goto out;
> -		llc->busy_state_timer.expire = opt * HZ;
> -		break;
> -	case LLC_OPT_TX_WIN:
> -		if (opt > LLC_OPT_MAX_WIN)
> -			goto out;
> -		llc->k = opt;
> -		break;
> -	case LLC_OPT_RX_WIN:
> -		if (opt > LLC_OPT_MAX_WIN)
> -			goto out;
> -		llc->rw = opt;
> -		break;
> -	case LLC_OPT_PKTINFO:
> -		if (opt)
> -			llc->cmsg_flags |= LLC_CMSG_PKTINFO;
> -		else
> -			llc->cmsg_flags &= ~LLC_CMSG_PKTINFO;
> -		break;
> -	default:
> -		rc = -ENOPROTOOPT;
> -		goto out;
> -	}
> -	rc = 0;
> -out:
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -/**
> - *	llc_ui_getsockopt - get connection specific socket info
> - *	@sock: Socket to get information from.
> - *	@level: Socket level user is requesting operations on.
> - *	@optname: Operation name.
> - *	@opt: sockopt context with iterator and length for returning data.
> - *
> - *	Get connection specific socket information.
> - */
> -static int llc_ui_getsockopt(struct socket *sock, int level, int optname,
> -			     sockopt_t *opt)
> -{
> -	struct sock *sk = sock->sk;
> -	struct llc_sock *llc = llc_sk(sk);
> -	int val = 0, len, rc = -EINVAL;
> -
> -	lock_sock(sk);
> -	if (unlikely(level != SOL_LLC))
> -		goto out;
> -	len = opt->optlen;
> -	if (len != sizeof(int))
> -		goto out;
> -	switch (optname) {
> -	case LLC_OPT_RETRY:
> -		val = llc->n2;					break;
> -	case LLC_OPT_SIZE:
> -		val = llc->n1;					break;
> -	case LLC_OPT_ACK_TMR_EXP:
> -		val = llc->ack_timer.expire / HZ;		break;
> -	case LLC_OPT_P_TMR_EXP:
> -		val = llc->pf_cycle_timer.expire / HZ;		break;
> -	case LLC_OPT_REJ_TMR_EXP:
> -		val = llc->rej_sent_timer.expire / HZ;		break;
> -	case LLC_OPT_BUSY_TMR_EXP:
> -		val = llc->busy_state_timer.expire / HZ;	break;
> -	case LLC_OPT_TX_WIN:
> -		val = llc->k;				break;
> -	case LLC_OPT_RX_WIN:
> -		val = llc->rw;				break;
> -	case LLC_OPT_PKTINFO:
> -		val = (llc->cmsg_flags & LLC_CMSG_PKTINFO) != 0;
> -		break;
> -	default:
> -		rc = -ENOPROTOOPT;
> -		goto out;
> -	}
> -	rc = 0;
> -	opt->optlen = len;
> -	if (copy_to_iter(&val, len, &opt->iter_out) != len)
> -		rc = -EFAULT;
> -out:
> -	release_sock(sk);
> -	return rc;
> -}
> -
> -static const struct net_proto_family llc_ui_family_ops = {
> -	.family = PF_LLC,
> -	.create = llc_ui_create,
> -	.owner	= THIS_MODULE,
> -};
> -
> -static const struct proto_ops llc_ui_ops = {
> -	.family	     = PF_LLC,
> -	.owner       = THIS_MODULE,
> -	.release     = llc_ui_release,
> -	.bind	     = llc_ui_bind,
> -	.connect     = llc_ui_connect,
> -	.socketpair  = sock_no_socketpair,
> -	.accept      = llc_ui_accept,
> -	.getname     = llc_ui_getname,
> -	.poll	     = datagram_poll,
> -	.ioctl       = llc_ui_ioctl,
> -	.listen      = llc_ui_listen,
> -	.shutdown    = llc_ui_shutdown,
> -	.setsockopt  = llc_ui_setsockopt,
> -	.getsockopt_iter = llc_ui_getsockopt,
> -	.sendmsg     = llc_ui_sendmsg,
> -	.recvmsg     = llc_ui_recvmsg,
> -	.mmap	     = sock_no_mmap,
> -};
> -
> -static const char llc_proc_err_msg[] __initconst =
> -	KERN_CRIT "LLC: Unable to register the proc_fs entries\n";
> -static const char llc_sysctl_err_msg[] __initconst =
> -	KERN_CRIT "LLC: Unable to register the sysctl entries\n";
> -static const char llc_sock_err_msg[] __initconst =
> -	KERN_CRIT "LLC: Unable to register the network family\n";
> -
> -static int __init llc2_init(void)
> -{
> -	int rc = proto_register(&llc_proto, 0);
> -
> -	if (rc != 0)
> -		goto out;
> -
> -	llc_build_offset_table();
> -	llc_station_init();
> -	llc_ui_sap_last_autoport = LLC_SAP_DYN_START;
> -	rc = llc_proc_init();
> -	if (rc != 0) {
> -		printk(llc_proc_err_msg);
> -		goto out_station;
> -	}
> -	rc = llc_sysctl_init();
> -	if (rc) {
> -		printk(llc_sysctl_err_msg);
> -		goto out_proc;
> -	}
> -	rc = sock_register(&llc_ui_family_ops);
> -	if (rc) {
> -		printk(llc_sock_err_msg);
> -		goto out_sysctl;
> -	}
> -	llc_add_pack(LLC_DEST_SAP, llc_sap_handler);
> -	llc_add_pack(LLC_DEST_CONN, llc_conn_handler);
> -out:
> -	return rc;
> -out_sysctl:
> -	llc_sysctl_exit();
> -out_proc:
> -	llc_proc_exit();
> -out_station:
> -	llc_station_exit();
> -	proto_unregister(&llc_proto);
> -	goto out;
> -}
> -
> -static void __exit llc2_exit(void)
> -{
> -	llc_station_exit();
> -	llc_remove_pack(LLC_DEST_SAP);
> -	llc_remove_pack(LLC_DEST_CONN);
> -	sock_unregister(PF_LLC);
> -	llc_proc_exit();
> -	llc_sysctl_exit();
> -	proto_unregister(&llc_proto);
> -}
> -
> -module_init(llc2_init);
> -module_exit(llc2_exit);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Procom 1997, Jay Schullist 2001, Arnaldo C. Melo 2001-2003");
> -MODULE_DESCRIPTION("IEEE 802.2 PF_LLC support");
> -MODULE_ALIAS_NETPROTO(PF_LLC);
> diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
> deleted file mode 100644
> index 1aa7fe28acdd..000000000000
> --- a/net/llc/llc_c_ac.c
> +++ /dev/null
> @@ -1,1448 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_c_ac.c - actions performed during connection state transition.
> - *
> - * Description:
> - *   Functions in this module are implementation of connection component actions
> - *   Details of actions can be found in IEEE-802.2 standard document.
> - *   All functions have one connection and one event as input argument. All of
> - *   them return 0 On success and 1 otherwise.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/netdevice.h>
> -#include <linux/slab.h>
> -#include <net/llc_conn.h>
> -#include <net/llc_sap.h>
> -#include <net/sock.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_st.h>
> -#include <net/llc_pdu.h>
> -#include <net/llc.h>
> -
> -
> -static int llc_conn_ac_inc_vs_by_1(struct sock *sk, struct sk_buff *skb);
> -static void llc_process_tmr_ev(struct sock *sk, struct sk_buff *skb);
> -static int llc_conn_ac_data_confirm(struct sock *sk, struct sk_buff *ev);
> -
> -static int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb);
> -
> -static int llc_conn_ac_send_rr_rsp_f_set_ackpf(struct sock *sk,
> -					       struct sk_buff *skb);
> -
> -static int llc_conn_ac_set_p_flag_1(struct sock *sk, struct sk_buff *skb);
> -
> -#define INCORRECT 0
> -
> -int llc_conn_ac_clear_remote_busy(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (llc->remote_busy_flag) {
> -		u8 nr;
> -		struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -		llc->remote_busy_flag = 0;
> -		timer_delete(&llc->busy_state_timer.timer);
> -		nr = LLC_I_GET_NR(pdu);
> -		llc_conn_resend_i_pdu_as_cmd(sk, nr, 0);
> -	}
> -	return 0;
> -}
> -
> -int llc_conn_ac_conn_ind(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->ind_prim = LLC_CONN_PRIM;
> -	return 0;
> -}
> -
> -int llc_conn_ac_conn_confirm(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->cfm_prim = LLC_CONN_PRIM;
> -	return 0;
> -}
> -
> -static int llc_conn_ac_data_confirm(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->cfm_prim = LLC_DATA_PRIM;
> -	return 0;
> -}
> -
> -int llc_conn_ac_data_ind(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_conn_rtn_pdu(sk, skb);
> -	return 0;
> -}
> -
> -int llc_conn_ac_disc_ind(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -	u8 reason = 0;
> -	int rc = 0;
> -
> -	if (ev->type == LLC_CONN_EV_TYPE_PDU) {
> -		struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -		if (LLC_PDU_IS_RSP(pdu) &&
> -		    LLC_PDU_TYPE_IS_U(pdu) &&
> -		    LLC_U_PDU_RSP(pdu) == LLC_2_PDU_RSP_DM)
> -			reason = LLC_DISC_REASON_RX_DM_RSP_PDU;
> -		else if (LLC_PDU_IS_CMD(pdu) &&
> -			   LLC_PDU_TYPE_IS_U(pdu) &&
> -			   LLC_U_PDU_CMD(pdu) == LLC_2_PDU_CMD_DISC)
> -			reason = LLC_DISC_REASON_RX_DISC_CMD_PDU;
> -	} else if (ev->type == LLC_CONN_EV_TYPE_ACK_TMR)
> -		reason = LLC_DISC_REASON_ACK_TMR_EXP;
> -	else
> -		rc = -EINVAL;
> -	if (!rc) {
> -		ev->reason   = reason;
> -		ev->ind_prim = LLC_DISC_PRIM;
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ac_disc_confirm(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->reason   = ev->status;
> -	ev->cfm_prim = LLC_DISC_PRIM;
> -	return 0;
> -}
> -
> -int llc_conn_ac_rst_ind(struct sock *sk, struct sk_buff *skb)
> -{
> -	u8 reason = 0;
> -	int rc = 1;
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	switch (ev->type) {
> -	case LLC_CONN_EV_TYPE_PDU:
> -		if (LLC_PDU_IS_RSP(pdu) &&
> -		    LLC_PDU_TYPE_IS_U(pdu) &&
> -		    LLC_U_PDU_RSP(pdu) == LLC_2_PDU_RSP_FRMR) {
> -			reason = LLC_RESET_REASON_LOCAL;
> -			rc = 0;
> -		} else if (LLC_PDU_IS_CMD(pdu) &&
> -			   LLC_PDU_TYPE_IS_U(pdu) &&
> -			   LLC_U_PDU_CMD(pdu) == LLC_2_PDU_CMD_SABME) {
> -			reason = LLC_RESET_REASON_REMOTE;
> -			rc = 0;
> -		}
> -		break;
> -	case LLC_CONN_EV_TYPE_ACK_TMR:
> -	case LLC_CONN_EV_TYPE_P_TMR:
> -	case LLC_CONN_EV_TYPE_REJ_TMR:
> -	case LLC_CONN_EV_TYPE_BUSY_TMR:
> -		if (llc->retry_count > llc->n2) {
> -			reason = LLC_RESET_REASON_LOCAL;
> -			rc = 0;
> -		}
> -		break;
> -	}
> -	if (!rc) {
> -		ev->reason   = reason;
> -		ev->ind_prim = LLC_RESET_PRIM;
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ac_rst_confirm(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->reason   = 0;
> -	ev->cfm_prim = LLC_RESET_PRIM;
> -	return 0;
> -}
> -
> -int llc_conn_ac_clear_remote_busy_if_f_eq_1(struct sock *sk,
> -					    struct sk_buff *skb)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	if (LLC_PDU_IS_RSP(pdu) &&
> -	    LLC_PDU_TYPE_IS_I(pdu) &&
> -	    LLC_I_PF_IS_1(pdu) && llc_sk(sk)->ack_pf)
> -		llc_conn_ac_clear_remote_busy(sk, skb);
> -	return 0;
> -}
> -
> -int llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2(struct sock *sk,
> -					       struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (llc->data_flag == 2)
> -		timer_delete(&llc->rej_sent_timer.timer);
> -	return 0;
> -}
> -
> -int llc_conn_ac_send_disc_cmd_p_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_CMD);
> -		llc_pdu_init_as_disc_cmd(nskb, 1);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -		llc_conn_ac_set_p_flag_1(sk, skb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_dm_rsp_f_set_p(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -		u8 f_bit;
> -
> -		llc_pdu_decode_pf_bit(skb, &f_bit);
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_dm_rsp(nskb, f_bit);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_dm_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_dm_rsp(nskb, 1);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_frmr_rsp_f_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	u8 f_bit;
> -	int rc = -ENOBUFS;
> -	struct sk_buff *nskb;
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc->rx_pdu_hdr = *((u32 *)pdu);
> -	if (LLC_PDU_IS_CMD(pdu))
> -		llc_pdu_decode_pf_bit(skb, &f_bit);
> -	else
> -		f_bit = 0;
> -	nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U,
> -			       sizeof(struct llc_frmr_info));
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_frmr_rsp(nskb, pdu, f_bit, llc->vS,
> -					 llc->vR, INCORRECT);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_resend_frmr_rsp_f_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U,
> -					       sizeof(struct llc_frmr_info));
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -		struct llc_pdu_sn *pdu = (struct llc_pdu_sn *)&llc->rx_pdu_hdr;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_frmr_rsp(nskb, pdu, 0, llc->vS,
> -					 llc->vR, INCORRECT);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_resend_frmr_rsp_f_set_p(struct sock *sk, struct sk_buff *skb)
> -{
> -	u8 f_bit;
> -	int rc = -ENOBUFS;
> -	struct sk_buff *nskb;
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc_pdu_decode_pf_bit(skb, &f_bit);
> -	nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U,
> -			       sizeof(struct llc_frmr_info));
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -		struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_frmr_rsp(nskb, pdu, f_bit, llc->vS,
> -					 llc->vR, INCORRECT);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_i_cmd_p_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct llc_sap *sap = llc->sap;
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_I, sap->laddr.lsap,
> -			    llc->daddr.lsap, LLC_PDU_CMD);
> -	llc_pdu_init_as_i_cmd(skb, 1, llc->vS, llc->vR);
> -	rc = llc_mac_hdr_init(skb, llc->dev->dev_addr, llc->daddr.mac);
> -	if (likely(!rc)) {
> -		skb_get(skb);
> -		llc_conn_send_pdu(sk, skb);
> -		llc_conn_ac_inc_vs_by_1(sk, skb);
> -	}
> -	return rc;
> -}
> -
> -static int llc_conn_ac_send_i_cmd_p_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct llc_sap *sap = llc->sap;
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_I, sap->laddr.lsap,
> -			    llc->daddr.lsap, LLC_PDU_CMD);
> -	llc_pdu_init_as_i_cmd(skb, 0, llc->vS, llc->vR);
> -	rc = llc_mac_hdr_init(skb, llc->dev->dev_addr, llc->daddr.mac);
> -	if (likely(!rc)) {
> -		skb_get(skb);
> -		llc_conn_send_pdu(sk, skb);
> -		llc_conn_ac_inc_vs_by_1(sk, skb);
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ac_send_i_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct llc_sap *sap = llc->sap;
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_I, sap->laddr.lsap,
> -			    llc->daddr.lsap, LLC_PDU_CMD);
> -	llc_pdu_init_as_i_cmd(skb, 0, llc->vS, llc->vR);
> -	rc = llc_mac_hdr_init(skb, llc->dev->dev_addr, llc->daddr.mac);
> -	if (likely(!rc)) {
> -		skb_get(skb);
> -		llc_conn_send_pdu(sk, skb);
> -		llc_conn_ac_inc_vs_by_1(sk, skb);
> -	}
> -	return 0;
> -}
> -
> -int llc_conn_ac_resend_i_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	u8 nr = LLC_I_GET_NR(pdu);
> -
> -	llc_conn_resend_i_pdu_as_cmd(sk, nr, 0);
> -	return 0;
> -}
> -
> -int llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr(struct sock *sk,
> -						struct sk_buff *skb)
> -{
> -	u8 nr;
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rr_rsp(nskb, 0, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (likely(!rc))
> -			llc_conn_send_pdu(sk, nskb);
> -		else
> -			kfree_skb(nskb);
> -	}
> -	if (rc) {
> -		nr = LLC_I_GET_NR(pdu);
> -		rc = 0;
> -		llc_conn_resend_i_pdu_as_cmd(sk, nr, 0);
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ac_resend_i_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	u8 nr = LLC_I_GET_NR(pdu);
> -
> -	llc_conn_resend_i_pdu_as_rsp(sk, nr, 1);
> -	return 0;
> -}
> -
> -int llc_conn_ac_send_rej_cmd_p_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_CMD);
> -		llc_pdu_init_as_rej_cmd(nskb, 1, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rej_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rej_rsp(nskb, 1, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rej_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rej_rsp(nskb, 0, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rnr_cmd_p_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_CMD);
> -		llc_pdu_init_as_rnr_cmd(nskb, 1, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rnr_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rnr_rsp(nskb, 1, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rnr_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rnr_rsp(nskb, 0, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_set_remote_busy(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (!llc->remote_busy_flag) {
> -		llc->remote_busy_flag = 1;
> -		mod_timer(&llc->busy_state_timer.timer,
> -			 jiffies + llc->busy_state_timer.expire);
> -	}
> -	return 0;
> -}
> -
> -int llc_conn_ac_opt_send_rnr_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rnr_rsp(nskb, 0, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rr_cmd_p_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_CMD);
> -		llc_pdu_init_as_rr_cmd(nskb, 1, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rr_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -		u8 f_bit = 1;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rr_rsp(nskb, f_bit, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_ack_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rr_rsp(nskb, 1, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_rr_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rr_rsp(nskb, 0, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_ack_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rr_rsp(nskb, 0, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -void llc_conn_set_p_flag(struct sock *sk, u8 value)
> -{
> -	int state_changed = llc_sk(sk)->p_flag && !value;
> -
> -	llc_sk(sk)->p_flag = value;
> -
> -	if (state_changed)
> -		sk->sk_state_change(sk);
> -}
> -
> -int llc_conn_ac_send_sabme_cmd_p_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -		const u8 *dmac = llc->daddr.mac;
> -
> -		if (llc->dev->flags & IFF_LOOPBACK)
> -			dmac = llc->dev->dev_addr;
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_CMD);
> -		llc_pdu_init_as_sabme_cmd(nskb, 1);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, dmac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -		llc_conn_set_p_flag(sk, 1);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_send_ua_rsp_f_set_p(struct sock *sk, struct sk_buff *skb)
> -{
> -	u8 f_bit;
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_U, 0);
> -
> -	llc_pdu_decode_pf_bit(skb, &f_bit);
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		nskb->dev = llc->dev;
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_ua_rsp(nskb, f_bit);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -int llc_conn_ac_set_s_flag_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->s_flag = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_s_flag_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->s_flag = 1;
> -	return 0;
> -}
> -
> -int llc_conn_ac_start_p_timer(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc_conn_set_p_flag(sk, 1);
> -	mod_timer(&llc->pf_cycle_timer.timer,
> -		  jiffies + llc->pf_cycle_timer.expire);
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_send_ack_if_needed - check if ack is needed
> - *	@sk: current connection structure
> - *	@skb: current event
> - *
> - *	Checks number of received PDUs which have not been acknowledged, yet,
> - *	If number of them reaches to "npta"(Number of PDUs To Acknowledge) then
> - *	sends an RR response as acknowledgement for them.  Returns 0 for
> - *	success, 1 otherwise.
> - */
> -int llc_conn_ac_send_ack_if_needed(struct sock *sk, struct sk_buff *skb)
> -{
> -	u8 pf_bit;
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc_pdu_decode_pf_bit(skb, &pf_bit);
> -	llc->ack_pf |= pf_bit & 1;
> -	if (!llc->ack_must_be_send) {
> -		llc->first_pdu_Ns = llc->vR;
> -		llc->ack_must_be_send = 1;
> -		llc->ack_pf = pf_bit & 1;
> -	}
> -	if (((llc->vR - llc->first_pdu_Ns + 1 + LLC_2_SEQ_NBR_MODULO)
> -			% LLC_2_SEQ_NBR_MODULO) >= llc->npta) {
> -		llc_conn_ac_send_rr_rsp_f_set_ackpf(sk, skb);
> -		llc->ack_must_be_send	= 0;
> -		llc->ack_pf		= 0;
> -		llc_conn_ac_inc_npta_value(sk, skb);
> -	}
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_rst_sendack_flag - resets ack_must_be_send flag
> - *	@sk: current connection structure
> - *	@skb: current event
> - *
> - *	This action resets ack_must_be_send flag of given connection, this flag
> - *	indicates if there is any PDU which has not been acknowledged yet.
> - *	Returns 0 for success, 1 otherwise.
> - */
> -int llc_conn_ac_rst_sendack_flag(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->ack_must_be_send = llc_sk(sk)->ack_pf = 0;
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_send_i_rsp_f_set_ackpf - acknowledge received PDUs
> - *	@sk: current connection structure
> - *	@skb: current event
> - *
> - *	Sends an I response PDU with f-bit set to ack_pf flag as acknowledge to
> - *	all received PDUs which have not been acknowledged, yet. ack_pf flag is
> - *	set to one if one PDU with p-bit set to one is received.  Returns 0 for
> - *	success, 1 otherwise.
> - */
> -static int llc_conn_ac_send_i_rsp_f_set_ackpf(struct sock *sk,
> -					      struct sk_buff *skb)
> -{
> -	int rc;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct llc_sap *sap = llc->sap;
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_I, sap->laddr.lsap,
> -			    llc->daddr.lsap, LLC_PDU_RSP);
> -	llc_pdu_init_as_i_cmd(skb, llc->ack_pf, llc->vS, llc->vR);
> -	rc = llc_mac_hdr_init(skb, llc->dev->dev_addr, llc->daddr.mac);
> -	if (likely(!rc)) {
> -		skb_get(skb);
> -		llc_conn_send_pdu(sk, skb);
> -		llc_conn_ac_inc_vs_by_1(sk, skb);
> -	}
> -	return rc;
> -}
> -
> -/**
> - *	llc_conn_ac_send_i_as_ack - sends an I-format PDU to acknowledge rx PDUs
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	This action sends an I-format PDU as acknowledge to received PDUs which
> - *	have not been acknowledged, yet, if there is any. By using of this
> - *	action number of acknowledgements decreases, this technic is called
> - *	piggy backing. Returns 0 for success, 1 otherwise.
> - */
> -int llc_conn_ac_send_i_as_ack(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -	int ret;
> -
> -	if (llc->ack_must_be_send) {
> -		ret = llc_conn_ac_send_i_rsp_f_set_ackpf(sk, skb);
> -		llc->ack_must_be_send = 0 ;
> -		llc->ack_pf = 0;
> -	} else {
> -		ret = llc_conn_ac_send_i_cmd_p_set_0(sk, skb);
> -	}
> -
> -	return ret;
> -}
> -
> -/**
> - *	llc_conn_ac_send_rr_rsp_f_set_ackpf - ack all rx PDUs not yet acked
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	This action sends an RR response with f-bit set to ack_pf flag as
> - *	acknowledge to all received PDUs which have not been acknowledged, yet,
> - *	if there is any. ack_pf flag indicates if a PDU has been received with
> - *	p-bit set to one. Returns 0 for success, 1 otherwise.
> - */
> -static int llc_conn_ac_send_rr_rsp_f_set_ackpf(struct sock *sk,
> -					       struct sk_buff *skb)
> -{
> -	int rc = -ENOBUFS;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sk_buff *nskb = llc_alloc_frame(sk, llc->dev, LLC_PDU_TYPE_S, 0);
> -
> -	if (nskb) {
> -		struct llc_sap *sap = llc->sap;
> -
> -		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
> -				    llc->daddr.lsap, LLC_PDU_RSP);
> -		llc_pdu_init_as_rr_rsp(nskb, llc->ack_pf, llc->vR);
> -		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
> -		if (unlikely(rc))
> -			goto free;
> -		llc_conn_send_pdu(sk, nskb);
> -	}
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -/**
> - *	llc_conn_ac_inc_npta_value - tries to make value of npta greater
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	After "inc_cntr" times calling of this action, "npta" increase by one.
> - *	this action tries to make vale of "npta" greater as possible; number of
> - *	acknowledgements decreases by increasing of "npta". Returns 0 for
> - *	success, 1 otherwise.
> - */
> -static int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (!llc->inc_cntr) {
> -		llc->dec_step = 0;
> -		llc->dec_cntr = llc->inc_cntr = 2;
> -		++llc->npta;
> -		if (llc->npta > LLC_2_SEQ_NBR_MODULO - 1)
> -			llc->npta = LLC_2_SEQ_NBR_MODULO - 1;
> -	} else
> -		--llc->inc_cntr;
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_adjust_npta_by_rr - decreases "npta" by one
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	After receiving "dec_cntr" times RR command, this action decreases
> - *	"npta" by one. Returns 0 for success, 1 otherwise.
> - */
> -int llc_conn_ac_adjust_npta_by_rr(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (!llc->connect_step && !llc->remote_busy_flag) {
> -		if (!llc->dec_step) {
> -			if (!llc->dec_cntr) {
> -				llc->inc_cntr = llc->dec_cntr = 2;
> -				if (llc->npta > 0)
> -					llc->npta = llc->npta - 1;
> -			} else
> -				llc->dec_cntr -=1;
> -		}
> -	} else
> -		llc->connect_step = 0 ;
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_adjust_npta_by_rnr - decreases "npta" by one
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	After receiving "dec_cntr" times RNR command, this action decreases
> - *	"npta" by one. Returns 0 for success, 1 otherwise.
> - */
> -int llc_conn_ac_adjust_npta_by_rnr(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (llc->remote_busy_flag)
> -		if (!llc->dec_step) {
> -			if (!llc->dec_cntr) {
> -				llc->inc_cntr = llc->dec_cntr = 2;
> -				if (llc->npta > 0)
> -					--llc->npta;
> -			} else
> -				--llc->dec_cntr;
> -		}
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_dec_tx_win_size - decreases tx window size
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	After receiving of a REJ command or response, transmit window size is
> - *	decreased by number of PDUs which are outstanding yet. Returns 0 for
> - *	success, 1 otherwise.
> - */
> -int llc_conn_ac_dec_tx_win_size(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -	u8 unacked_pdu = skb_queue_len(&llc->pdu_unack_q);
> -
> -	if (llc->k - unacked_pdu < 1)
> -		llc->k = 1;
> -	else
> -		llc->k -= unacked_pdu;
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_ac_inc_tx_win_size - tx window size is inc by 1
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	After receiving an RR response with f-bit set to one, transmit window
> - *	size is increased by one. Returns 0 for success, 1 otherwise.
> - */
> -int llc_conn_ac_inc_tx_win_size(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc->k += 1;
> -	if (llc->k > LLC_2_SEQ_NBR_MODULO - 1)
> -		llc->k = LLC_2_SEQ_NBR_MODULO - 1;
> -	return 0;
> -}
> -
> -int llc_conn_ac_stop_all_timers(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk_stop_all_timers(sk, false);
> -	return 0;
> -}
> -
> -int llc_conn_ac_stop_other_timers(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	timer_delete(&llc->rej_sent_timer.timer);
> -	timer_delete(&llc->pf_cycle_timer.timer);
> -	timer_delete(&llc->busy_state_timer.timer);
> -	llc->ack_must_be_send = 0;
> -	llc->ack_pf = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_start_ack_timer(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	mod_timer(&llc->ack_timer.timer, jiffies + llc->ack_timer.expire);
> -	return 0;
> -}
> -
> -int llc_conn_ac_start_rej_timer(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	mod_timer(&llc->rej_sent_timer.timer,
> -		  jiffies + llc->rej_sent_timer.expire);
> -	return 0;
> -}
> -
> -int llc_conn_ac_start_ack_tmr_if_not_running(struct sock *sk,
> -					     struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (!timer_pending(&llc->ack_timer.timer))
> -		mod_timer(&llc->ack_timer.timer,
> -			  jiffies + llc->ack_timer.expire);
> -	return 0;
> -}
> -
> -int llc_conn_ac_stop_ack_timer(struct sock *sk, struct sk_buff *skb)
> -{
> -	timer_delete(&llc_sk(sk)->ack_timer.timer);
> -	return 0;
> -}
> -
> -int llc_conn_ac_stop_p_timer(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	timer_delete(&llc->pf_cycle_timer.timer);
> -	llc_conn_set_p_flag(sk, 0);
> -	return 0;
> -}
> -
> -int llc_conn_ac_stop_rej_timer(struct sock *sk, struct sk_buff *skb)
> -{
> -	timer_delete(&llc_sk(sk)->rej_sent_timer.timer);
> -	return 0;
> -}
> -
> -int llc_conn_ac_upd_nr_received(struct sock *sk, struct sk_buff *skb)
> -{
> -	int acked;
> -	u16 unacked = 0;
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc->last_nr = PDU_SUPV_GET_Nr(pdu);
> -	acked = llc_conn_remove_acked_pdus(sk, llc->last_nr, &unacked);
> -	/* On loopback we don't queue I frames in unack_pdu_q queue. */
> -	if (acked > 0 || (llc->dev->flags & IFF_LOOPBACK)) {
> -		llc->retry_count = 0;
> -		timer_delete(&llc->ack_timer.timer);
> -		if (llc->failed_data_req) {
> -			/* already, we did not accept data from upper layer
> -			 * (tx_window full or unacceptable state). Now, we
> -			 * can send data and must inform to upper layer.
> -			 */
> -			llc->failed_data_req = 0;
> -			llc_conn_ac_data_confirm(sk, skb);
> -		}
> -		if (unacked)
> -			mod_timer(&llc->ack_timer.timer,
> -				  jiffies + llc->ack_timer.expire);
> -	} else if (llc->failed_data_req) {
> -		u8 f_bit;
> -
> -		llc_pdu_decode_pf_bit(skb, &f_bit);
> -		if (f_bit == 1) {
> -			llc->failed_data_req = 0;
> -			llc_conn_ac_data_confirm(sk, skb);
> -		}
> -	}
> -	return 0;
> -}
> -
> -int llc_conn_ac_upd_p_flag(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	if (LLC_PDU_IS_RSP(pdu)) {
> -		u8 f_bit;
> -
> -		llc_pdu_decode_pf_bit(skb, &f_bit);
> -		if (f_bit) {
> -			llc_conn_set_p_flag(sk, 0);
> -			llc_conn_ac_stop_p_timer(sk, skb);
> -		}
> -	}
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_data_flag_2(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->data_flag = 2;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_data_flag_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->data_flag = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_data_flag_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->data_flag = 1;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_data_flag_1_if_data_flag_eq_0(struct sock *sk,
> -						  struct sk_buff *skb)
> -{
> -	if (!llc_sk(sk)->data_flag)
> -		llc_sk(sk)->data_flag = 1;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_p_flag_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_conn_set_p_flag(sk, 0);
> -	return 0;
> -}
> -
> -static int llc_conn_ac_set_p_flag_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_conn_set_p_flag(sk, 1);
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_remote_busy_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->remote_busy_flag = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_cause_flag_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->cause_flag = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_cause_flag_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->cause_flag = 1;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_retry_cnt_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->retry_count = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_inc_retry_cnt_by_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->retry_count++;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_vr_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->vR = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_inc_vr_by_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->vR = PDU_GET_NEXT_Vr(llc_sk(sk)->vR);
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_vs_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->vS = 0;
> -	return 0;
> -}
> -
> -int llc_conn_ac_set_vs_nr(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->vS = llc_sk(sk)->last_nr;
> -	return 0;
> -}
> -
> -static int llc_conn_ac_inc_vs_by_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->vS = (llc_sk(sk)->vS + 1) % LLC_2_SEQ_NBR_MODULO;
> -	return 0;
> -}
> -
> -static void llc_conn_tmr_common_cb(struct sock *sk, u8 type)
> -{
> -	struct sk_buff *skb = alloc_skb(0, GFP_ATOMIC);
> -
> -	bh_lock_sock(sk);
> -	if (skb) {
> -		struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -		skb_set_owner_r(skb, sk);
> -		ev->type = type;
> -		llc_process_tmr_ev(sk, skb);
> -	}
> -	bh_unlock_sock(sk);
> -}
> -
> -void llc_conn_pf_cycle_tmr_cb(struct timer_list *t)
> -{
> -	struct llc_sock *llc = timer_container_of(llc, t,
> -						  pf_cycle_timer.timer);
> -
> -	llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_P_TMR);
> -}
> -
> -void llc_conn_busy_tmr_cb(struct timer_list *t)
> -{
> -	struct llc_sock *llc = timer_container_of(llc, t,
> -						  busy_state_timer.timer);
> -
> -	llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_BUSY_TMR);
> -}
> -
> -void llc_conn_ack_tmr_cb(struct timer_list *t)
> -{
> -	struct llc_sock *llc = timer_container_of(llc, t, ack_timer.timer);
> -
> -	llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_ACK_TMR);
> -}
> -
> -void llc_conn_rej_tmr_cb(struct timer_list *t)
> -{
> -	struct llc_sock *llc = timer_container_of(llc, t,
> -						  rej_sent_timer.timer);
> -
> -	llc_conn_tmr_common_cb(&llc->sk, LLC_CONN_EV_TYPE_REJ_TMR);
> -}
> -
> -int llc_conn_ac_rst_vs(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk(sk)->X = llc_sk(sk)->vS;
> -	llc_conn_ac_set_vs_nr(sk, skb);
> -	return 0;
> -}
> -
> -int llc_conn_ac_upd_vs(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	u8 nr = PDU_SUPV_GET_Nr(pdu);
> -
> -	if (llc_circular_between(llc_sk(sk)->vS, nr, llc_sk(sk)->X))
> -		llc_conn_ac_set_vs_nr(sk, skb);
> -	return 0;
> -}
> -
> -/*
> - * Non-standard actions; these not contained in IEEE specification; for
> - * our own usage
> - */
> -/**
> - *	llc_conn_disc - removes connection from SAP list and frees it
> - *	@sk: closed connection
> - *	@skb: occurred event
> - */
> -int llc_conn_disc(struct sock *sk, struct sk_buff *skb)
> -{
> -	/* FIXME: this thing seems to want to die */
> -	return 0;
> -}
> -
> -/**
> - *	llc_conn_reset - resets connection
> - *	@sk : reseting connection.
> - *	@skb: occurred event.
> - *
> - *	Stop all timers, empty all queues and reset all flags.
> - */
> -int llc_conn_reset(struct sock *sk, struct sk_buff *skb)
> -{
> -	llc_sk_reset(sk);
> -	return 0;
> -}
> -
> -/**
> - *	llc_circular_between - designates that b is between a and c or not
> - *	@a: lower bound
> - *	@b: element to see if is between a and b
> - *	@c: upper bound
> - *
> - *	This function designates that b is between a and c or not (for example,
> - *	0 is between 127 and 1). Returns 1 if b is between a and c, 0
> - *	otherwise.
> - */
> -u8 llc_circular_between(u8 a, u8 b, u8 c)
> -{
> -	b = b - a;
> -	c = c - a;
> -	return b <= c;
> -}
> -
> -/**
> - *	llc_process_tmr_ev - timer backend
> - *	@sk: active connection
> - *	@skb: occurred event
> - *
> - *	This function is called from timer callback functions. When connection
> - *	is busy (during sending a data frame) timer expiration event must be
> - *	queued. Otherwise this event can be sent to connection state machine.
> - *	Queued events will process by llc_backlog_rcv function after sending
> - *	data frame.
> - */
> -static void llc_process_tmr_ev(struct sock *sk, struct sk_buff *skb)
> -{
> -	if (llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC) {
> -		printk(KERN_WARNING "%s: timer called on closed connection\n",
> -		       __func__);
> -		kfree_skb(skb);
> -	} else {
> -		if (!sock_owned_by_user(sk))
> -			llc_conn_state_process(sk, skb);
> -		else {
> -			llc_set_backlog_type(skb, LLC_EVENT);
> -			__sk_add_backlog(sk, skb);
> -		}
> -	}
> -}
> diff --git a/net/llc/llc_c_ev.c b/net/llc/llc_c_ev.c
> deleted file mode 100644
> index beb2836c7db0..000000000000
> --- a/net/llc/llc_c_ev.c
> +++ /dev/null
> @@ -1,742 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_c_ev.c - Connection component state transition event qualifiers
> - *
> - * A 'state' consists of a number of possible event matching functions,
> - * the actions associated with each being executed when that event is
> - * matched; a 'state machine' accepts events in a serial fashion from an
> - * event queue. Each event is passed to each successive event matching
> - * function until a match is made (the event matching function returns
> - * success, or '0') or the list of event matching functions is exhausted.
> - * If a match is made, the actions associated with the event are executed
> - * and the state is changed to that event's transition state. Before some
> - * events are recognized, even after a match has been made, a certain
> - * number of 'event qualifier' functions must also be executed. If these
> - * all execute successfully, then the event is finally executed.
> - *
> - * These event functions must return 0 for success, to show a matched
> - * event, of 1 if the event does not match. Event qualifier functions
> - * must return a 0 for success or a non-zero for failure. Each function
> - * is simply responsible for verifying one single thing and returning
> - * either a success or failure.
> - *
> - * All of followed event functions are described in 802.2 LLC Protocol
> - * standard document except two functions that we added that will explain
> - * in their comments, at below.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/netdevice.h>
> -#include <net/llc_conn.h>
> -#include <net/llc_sap.h>
> -#include <net/sock.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_pdu.h>
> -
> -#if 1
> -#define dprintk(args...) printk(KERN_DEBUG args)
> -#else
> -#define dprintk(args...)
> -#endif
> -
> -/**
> - *	llc_util_ns_inside_rx_window - check if sequence number is in rx window
> - *	@ns: sequence number of received pdu.
> - *	@vr: sequence number which receiver expects to receive.
> - *	@rw: receive window size of receiver.
> - *
> - *	Checks if sequence number of received PDU is in range of receive
> - *	window. Returns 0 for success, 1 otherwise
> - */
> -static u16 llc_util_ns_inside_rx_window(u8 ns, u8 vr, u8 rw)
> -{
> -	return !llc_circular_between(vr, ns,
> -				     (vr + rw - 1) % LLC_2_SEQ_NBR_MODULO);
> -}
> -
> -/**
> - *	llc_util_nr_inside_tx_window - check if sequence number is in tx window
> - *	@sk: current connection.
> - *	@nr: N(R) of received PDU.
> - *
> - *	This routine checks if N(R) of received PDU is in range of transmit
> - *	window; on the other hand checks if received PDU acknowledges some
> - *	outstanding PDUs that are in transmit window. Returns 0 for success, 1
> - *	otherwise.
> - */
> -static u16 llc_util_nr_inside_tx_window(struct sock *sk, u8 nr)
> -{
> -	u8 nr1, nr2;
> -	struct sk_buff *skb;
> -	struct llc_pdu_sn *pdu;
> -	struct llc_sock *llc = llc_sk(sk);
> -	int rc = 0;
> -
> -	if (llc->dev->flags & IFF_LOOPBACK)
> -		goto out;
> -	rc = 1;
> -	if (skb_queue_empty(&llc->pdu_unack_q))
> -		goto out;
> -	skb = skb_peek(&llc->pdu_unack_q);
> -	pdu = llc_pdu_sn_hdr(skb);
> -	nr1 = LLC_I_GET_NS(pdu);
> -	skb = skb_peek_tail(&llc->pdu_unack_q);
> -	pdu = llc_pdu_sn_hdr(skb);
> -	nr2 = LLC_I_GET_NS(pdu);
> -	rc = !llc_circular_between(nr1, nr, (nr2 + 1) % LLC_2_SEQ_NBR_MODULO);
> -out:
> -	return rc;
> -}
> -
> -int llc_conn_ev_conn_req(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->prim == LLC_CONN_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_data_req(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->prim == LLC_DATA_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_disc_req(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->prim == LLC_DISC_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rst_req(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->prim == LLC_RESET_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_local_busy_detected(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type == LLC_CONN_EV_TYPE_SIMPLE &&
> -	       ev->prim_type == LLC_CONN_EV_LOCAL_BUSY_DETECTED ? 0 : 1;
> -}
> -
> -int llc_conn_ev_local_busy_cleared(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type == LLC_CONN_EV_TYPE_SIMPLE &&
> -	       ev->prim_type == LLC_CONN_EV_LOCAL_BUSY_CLEARED ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_bad_pdu(struct sock *sk, struct sk_buff *skb)
> -{
> -	return 1;
> -}
> -
> -int llc_conn_ev_rx_disc_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_CMD(pdu) == LLC_2_PDU_CMD_DISC ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_dm_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_RSP(pdu) == LLC_2_PDU_RSP_DM ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_frmr_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_RSP(pdu) == LLC_2_PDU_RSP_FRMR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return llc_conn_space(sk, skb) &&
> -	       LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_0(pdu) &&
> -	       LLC_I_GET_NS(pdu) == llc_sk(sk)->vR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return llc_conn_space(sk, skb) &&
> -	       LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_1(pdu) &&
> -	       LLC_I_GET_NS(pdu) == llc_sk(sk)->vR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_0(pdu) && ns != vr &&
> -	       !llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_1(pdu) && ns != vr &&
> -	       !llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_cmd_pbit_set_x_inval_ns(struct sock *sk,
> -					     struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn * pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -	const u16 rc = LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -		ns != vr &&
> -		 llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -	if (!rc)
> -		dprintk("%s: matched, state=%d, ns=%d, vr=%d\n",
> -			__func__, llc_sk(sk)->state, ns, vr);
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return llc_conn_space(sk, skb) &&
> -	       LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_0(pdu) &&
> -	       LLC_I_GET_NS(pdu) == llc_sk(sk)->vR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_1(pdu) &&
> -	       LLC_I_GET_NS(pdu) == llc_sk(sk)->vR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return llc_conn_space(sk, skb) &&
> -	       LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_GET_NS(pdu) == llc_sk(sk)->vR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_0(pdu) && ns != vr &&
> -	       !llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -	       LLC_I_PF_IS_1(pdu) && ns != vr &&
> -	       !llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_x_unexpd_ns(struct sock *sk,
> -					      struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) && ns != vr &&
> -	       !llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_i_rsp_fbit_set_x_inval_ns(struct sock *sk,
> -					     struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vr = llc_sk(sk)->vR;
> -	const u8 ns = LLC_I_GET_NS(pdu);
> -	const u16 rc = LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_I(pdu) &&
> -		ns != vr &&
> -		 llc_util_ns_inside_rx_window(ns, vr, llc_sk(sk)->rw) ? 0 : 1;
> -	if (!rc)
> -		dprintk("%s: matched, state=%d, ns=%d, vr=%d\n",
> -			__func__, llc_sk(sk)->state, ns, vr);
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_rej_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_0(pdu) &&
> -	       LLC_S_PDU_CMD(pdu) == LLC_2_PDU_CMD_REJ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rej_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_1(pdu) &&
> -	       LLC_S_PDU_CMD(pdu) == LLC_2_PDU_CMD_REJ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rej_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_0(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_REJ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rej_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_1(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_REJ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rej_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_REJ ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rnr_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_0(pdu) &&
> -	       LLC_S_PDU_CMD(pdu) == LLC_2_PDU_CMD_RNR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rnr_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_1(pdu) &&
> -	       LLC_S_PDU_CMD(pdu) == LLC_2_PDU_CMD_RNR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rnr_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_0(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_RNR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rnr_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_1(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_RNR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rr_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_0(pdu) &&
> -	       LLC_S_PDU_CMD(pdu) == LLC_2_PDU_CMD_RR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rr_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_1(pdu) &&
> -	       LLC_S_PDU_CMD(pdu) == LLC_2_PDU_CMD_RR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rr_rsp_fbit_set_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return llc_conn_space(sk, skb) &&
> -	       LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_0(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_RR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_rr_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	return llc_conn_space(sk, skb) &&
> -	       LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_S(pdu) &&
> -	       LLC_S_PF_IS_1(pdu) &&
> -	       LLC_S_PDU_RSP(pdu) == LLC_2_PDU_RSP_RR ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_sabme_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) && LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_CMD(pdu) == LLC_2_PDU_CMD_SABME ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_ua_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_RSP(pdu) && LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_RSP(pdu) == LLC_2_PDU_RSP_UA ? 0 : 1;
> -}
> -
> -int llc_conn_ev_rx_xxx_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	u16 rc = 1;
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	if (LLC_PDU_IS_CMD(pdu)) {
> -		if (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu)) {
> -			if (LLC_I_PF_IS_1(pdu))
> -				rc = 0;
> -		} else if (LLC_PDU_TYPE_IS_U(pdu) && LLC_U_PF_IS_1(pdu))
> -			rc = 0;
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_xxx_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	u16 rc = 1;
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	if (LLC_PDU_IS_CMD(pdu)) {
> -		if (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu))
> -			rc = 0;
> -		else if (LLC_PDU_TYPE_IS_U(pdu))
> -			switch (LLC_U_PDU_CMD(pdu)) {
> -			case LLC_2_PDU_CMD_SABME:
> -			case LLC_2_PDU_CMD_DISC:
> -				rc = 0;
> -				break;
> -			}
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_xxx_rsp_fbit_set_x(struct sock *sk, struct sk_buff *skb)
> -{
> -	u16 rc = 1;
> -	const struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	if (LLC_PDU_IS_RSP(pdu)) {
> -		if (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu))
> -			rc = 0;
> -		else if (LLC_PDU_TYPE_IS_U(pdu))
> -			switch (LLC_U_PDU_RSP(pdu)) {
> -			case LLC_2_PDU_RSP_UA:
> -			case LLC_2_PDU_RSP_DM:
> -			case LLC_2_PDU_RSP_FRMR:
> -				rc = 0;
> -				break;
> -			}
> -	}
> -
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_zzz_cmd_pbit_set_x_inval_nr(struct sock *sk,
> -					       struct sk_buff *skb)
> -{
> -	u16 rc = 1;
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vs = llc_sk(sk)->vS;
> -	const u8 nr = LLC_I_GET_NR(pdu);
> -
> -	if (LLC_PDU_IS_CMD(pdu) &&
> -	    (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu)) &&
> -	    nr != vs && llc_util_nr_inside_tx_window(sk, nr)) {
> -		dprintk("%s: matched, state=%d, vs=%d, nr=%d\n",
> -			__func__, llc_sk(sk)->state, vs, nr);
> -		rc = 0;
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_zzz_rsp_fbit_set_x_inval_nr(struct sock *sk,
> -					       struct sk_buff *skb)
> -{
> -	u16 rc = 1;
> -	const struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -	const u8 vs = llc_sk(sk)->vS;
> -	const u8 nr = LLC_I_GET_NR(pdu);
> -
> -	if (LLC_PDU_IS_RSP(pdu) &&
> -	    (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu)) &&
> -	    nr != vs && llc_util_nr_inside_tx_window(sk, nr)) {
> -		rc = 0;
> -		dprintk("%s: matched, state=%d, vs=%d, nr=%d\n",
> -			__func__, llc_sk(sk)->state, vs, nr);
> -	}
> -	return rc;
> -}
> -
> -int llc_conn_ev_rx_any_frame(struct sock *sk, struct sk_buff *skb)
> -{
> -	return 0;
> -}
> -
> -int llc_conn_ev_p_tmr_exp(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type != LLC_CONN_EV_TYPE_P_TMR;
> -}
> -
> -int llc_conn_ev_ack_tmr_exp(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type != LLC_CONN_EV_TYPE_ACK_TMR;
> -}
> -
> -int llc_conn_ev_rej_tmr_exp(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type != LLC_CONN_EV_TYPE_REJ_TMR;
> -}
> -
> -int llc_conn_ev_busy_tmr_exp(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type != LLC_CONN_EV_TYPE_BUSY_TMR;
> -}
> -
> -int llc_conn_ev_init_p_f_cycle(struct sock *sk, struct sk_buff *skb)
> -{
> -	return 1;
> -}
> -
> -int llc_conn_ev_tx_buffer_full(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	return ev->type == LLC_CONN_EV_TYPE_SIMPLE &&
> -	       ev->prim_type == LLC_CONN_EV_TX_BUFF_FULL ? 0 : 1;
> -}
> -
> -/* Event qualifier functions
> - *
> - * these functions simply verify the value of a state flag associated with
> - * the connection and return either a 0 for success or a non-zero value
> - * for not-success; verify the event is the type we expect
> - */
> -int llc_conn_ev_qlfy_data_flag_eq_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->data_flag != 1;
> -}
> -
> -int llc_conn_ev_qlfy_data_flag_eq_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->data_flag;
> -}
> -
> -int llc_conn_ev_qlfy_data_flag_eq_2(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->data_flag != 2;
> -}
> -
> -int llc_conn_ev_qlfy_p_flag_eq_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->p_flag != 1;
> -}
> -
> -/**
> - *	llc_conn_ev_qlfy_last_frame_eq_1 - checks if frame is last in tx window
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	This function determines when frame which is sent, is last frame of
> - *	transmit window, if it is then this function return zero else return
> - *	one.  This function is used for sending last frame of transmit window
> - *	as I-format command with p-bit set to one. Returns 0 if frame is last
> - *	frame, 1 otherwise.
> - */
> -int llc_conn_ev_qlfy_last_frame_eq_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	return !(skb_queue_len(&llc_sk(sk)->pdu_unack_q) + 1 == llc_sk(sk)->k);
> -}
> -
> -/**
> - *	llc_conn_ev_qlfy_last_frame_eq_0 - checks if frame isn't last in tx window
> - *	@sk: current connection structure.
> - *	@skb: current event.
> - *
> - *	This function determines when frame which is sent, isn't last frame of
> - *	transmit window, if it isn't then this function return zero else return
> - *	one. Returns 0 if frame isn't last frame, 1 otherwise.
> - */
> -int llc_conn_ev_qlfy_last_frame_eq_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	return skb_queue_len(&llc_sk(sk)->pdu_unack_q) + 1 == llc_sk(sk)->k;
> -}
> -
> -int llc_conn_ev_qlfy_p_flag_eq_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->p_flag;
> -}
> -
> -int llc_conn_ev_qlfy_p_flag_eq_f(struct sock *sk, struct sk_buff *skb)
> -{
> -	u8 f_bit;
> -
> -	llc_pdu_decode_pf_bit(skb, &f_bit);
> -	return llc_sk(sk)->p_flag == f_bit ? 0 : 1;
> -}
> -
> -int llc_conn_ev_qlfy_remote_busy_eq_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->remote_busy_flag;
> -}
> -
> -int llc_conn_ev_qlfy_remote_busy_eq_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	return !llc_sk(sk)->remote_busy_flag;
> -}
> -
> -int llc_conn_ev_qlfy_retry_cnt_lt_n2(struct sock *sk, struct sk_buff *skb)
> -{
> -	return !(llc_sk(sk)->retry_count < llc_sk(sk)->n2);
> -}
> -
> -int llc_conn_ev_qlfy_retry_cnt_gte_n2(struct sock *sk, struct sk_buff *skb)
> -{
> -	return !(llc_sk(sk)->retry_count >= llc_sk(sk)->n2);
> -}
> -
> -int llc_conn_ev_qlfy_s_flag_eq_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	return !llc_sk(sk)->s_flag;
> -}
> -
> -int llc_conn_ev_qlfy_s_flag_eq_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->s_flag;
> -}
> -
> -int llc_conn_ev_qlfy_cause_flag_eq_1(struct sock *sk, struct sk_buff *skb)
> -{
> -	return !llc_sk(sk)->cause_flag;
> -}
> -
> -int llc_conn_ev_qlfy_cause_flag_eq_0(struct sock *sk, struct sk_buff *skb)
> -{
> -	return llc_sk(sk)->cause_flag;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_conn(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_CONN;
> -	return 0;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_disc(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_DISC;
> -	return 0;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_failed(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_FAILED;
> -	return 0;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_remote_busy(struct sock *sk,
> -					    struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_REMOTE_BUSY;
> -	return 0;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_refuse(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_REFUSE;
> -	return 0;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_conflict(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_CONFLICT;
> -	return 0;
> -}
> -
> -int llc_conn_ev_qlfy_set_status_rst_done(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->status = LLC_STATUS_RESET_DONE;
> -	return 0;
> -}
> diff --git a/net/llc/llc_c_st.c b/net/llc/llc_c_st.c
> deleted file mode 100644
> index 5fbd8d19c6c4..000000000000
> --- a/net/llc/llc_c_st.c
> +++ /dev/null
> @@ -1,4940 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_c_st.c - This module contains state transition of connection component.
> - *
> - * Description of event functions and actions there is in 802.2 LLC standard,
> - * or in "llc_c_ac.c" and "llc_c_ev.c" modules.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/types.h>
> -#include <net/llc_if.h>
> -#include <net/llc_sap.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_st.h>
> -
> -#define NONE NULL
> -
> -/* COMMON CONNECTION STATE transitions
> - * Common transitions for
> - * LLC_CONN_STATE_NORMAL,
> - * LLC_CONN_STATE_BUSY,
> - * LLC_CONN_STATE_REJ,
> - * LLC_CONN_STATE_AWAIT,
> - * LLC_CONN_STATE_AWAIT_BUSY and
> - * LLC_CONN_STATE_AWAIT_REJ states
> - */
> -/* State transitions for LLC_CONN_EV_DISC_REQ event */
> -static const llc_conn_action_t llc_common_actions_1[] = {
> -	[0] = llc_conn_ac_send_disc_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_1 = {
> -	.ev	       = llc_conn_ev_disc_req,
> -	.next_state    = LLC_CONN_STATE_D_CONN,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RESET_REQ event */
> -static const llc_conn_action_t llc_common_actions_2[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rst_req,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_common_actions_3[] = {
> -	[0] = llc_conn_ac_stop_all_timers,
> -	[1] = llc_conn_ac_set_vs_0,
> -	[2] = llc_conn_ac_set_vr_0,
> -	[3] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[4] = llc_conn_ac_rst_ind,
> -	[5] = llc_conn_ac_set_p_flag_0,
> -	[6] = llc_conn_ac_set_remote_busy_0,
> -	[7] = llc_conn_reset,
> -	[8] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_3 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_common_actions_4[] = {
> -	[0] = llc_conn_ac_stop_all_timers,
> -	[1] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[2] = llc_conn_ac_disc_ind,
> -	[3] = llc_conn_disc,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_FRMR_RSP_Fbit_SET_X event */
> -static const llc_conn_action_t llc_common_actions_5[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_rst_ind,
> -	[5] = llc_conn_ac_set_cause_flag_0,
> -	[6] = llc_conn_reset,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_5 = {
> -	.ev	       = llc_conn_ev_rx_frmr_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event */
> -static const llc_conn_action_t llc_common_actions_6[] = {
> -	[0] = llc_conn_ac_disc_ind,
> -	[1] = llc_conn_ac_stop_all_timers,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_6 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_ZZZ_CMD_Pbit_SET_X_INVAL_Nr event */
> -static const llc_conn_action_t llc_common_actions_7a[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_7a = {
> -	.ev	       = llc_conn_ev_rx_zzz_cmd_pbit_set_x_inval_nr,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_7a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_X_INVAL_Ns event */
> -static const llc_conn_action_t llc_common_actions_7b[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_7b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_x_inval_ns,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_7b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_ZZZ_RSP_Fbit_SET_X_INVAL_Nr event */
> -static const llc_conn_action_t llc_common_actions_8a[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_8a = {
> -	.ev	       = llc_conn_ev_rx_zzz_rsp_fbit_set_x_inval_nr,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_8a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_X_INVAL_Ns event */
> -static const llc_conn_action_t llc_common_actions_8b[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_8b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x_inval_ns,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_8b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_BAD_PDU event */
> -static const llc_conn_action_t llc_common_actions_8c[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_8c = {
> -	.ev	       = llc_conn_ev_rx_bad_pdu,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_8c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X event */
> -static const llc_conn_action_t llc_common_actions_9[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_9 = {
> -	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_common_actions_9,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_XXX_RSP_Fbit_SET_1 event */
> -#if 0
> -static const llc_conn_ev_qfyr_t llc_common_ev_qfyrs_10[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_common_actions_10[] = {
> -	[0] = llc_conn_ac_send_frmr_rsp_f_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_10 = {
> -	.ev	       = llc_conn_ev_rx_xxx_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = llc_common_ev_qfyrs_10,
> -	.ev_actions    = llc_common_actions_10,
> -};
> -#endif
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_common_ev_qfyrs_11a[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_common_actions_11a[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_0,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_11a = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_common_ev_qfyrs_11a,
> -	.ev_actions    = llc_common_actions_11a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_common_ev_qfyrs_11b[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_common_actions_11b[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_0,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_11b = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_common_ev_qfyrs_11b,
> -	.ev_actions    = llc_common_actions_11b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_REJ_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_common_ev_qfyrs_11c[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_common_actions_11c[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_0,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_11c = {
> -	.ev	       = llc_conn_ev_rej_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_common_ev_qfyrs_11c,
> -	.ev_actions    = llc_common_actions_11c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_BUSY_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_common_ev_qfyrs_11d[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_common_actions_11d[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_stop_other_timers,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_0,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_common_state_trans_11d = {
> -	.ev	       = llc_conn_ev_busy_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_common_ev_qfyrs_11d,
> -	.ev_actions    = llc_common_actions_11d,
> -};
> -
> -/*
> - * Common dummy state transition; must be last entry for all state
> - * transition groups - it'll be on .bss, so will be zeroed.
> - */
> -static const struct llc_conn_state_trans llc_common_state_trans_end;
> -
> -/* LLC_CONN_STATE_ADM transitions */
> -/* State transitions for LLC_CONN_EV_CONN_REQ event */
> -static const llc_conn_action_t llc_adm_actions_1[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_set_retry_cnt_0,
> -	[3] = llc_conn_ac_set_s_flag_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_adm_state_trans_1 = {
> -	.ev	       = llc_conn_ev_conn_req,
> -	.next_state    = LLC_CONN_STATE_SETUP,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_adm_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_adm_actions_2[] = {
> -	[0] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[1] = llc_conn_ac_set_vs_0,
> -	[2] = llc_conn_ac_set_vr_0,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_p_flag_0,
> -	[5] = llc_conn_ac_set_remote_busy_0,
> -	[6] = llc_conn_ac_conn_ind,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_adm_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_adm_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_adm_actions_3[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_adm_state_trans_3 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_adm_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_XXX_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_adm_actions_4[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_1,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_adm_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_xxx_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_adm_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_XXX_YYY event */
> -static const llc_conn_action_t llc_adm_actions_5[] = {
> -	[0] = llc_conn_disc,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_adm_state_trans_5 = {
> -	.ev	       = llc_conn_ev_rx_any_frame,
> -	.next_state    = LLC_CONN_OUT_OF_SVC,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_adm_actions_5,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_adm_state_transitions[] = {
> -	[0] = &llc_adm_state_trans_1,		/* Request */
> -	[1] = &llc_common_state_trans_end,
> -	[2] = &llc_common_state_trans_end,	/* local_busy */
> -	[3] = &llc_common_state_trans_end,	/* init_pf_cycle */
> -	[4] = &llc_common_state_trans_end,	/* timer */
> -	[5] = &llc_adm_state_trans_2,		/* Receive frame */
> -	[6] = &llc_adm_state_trans_3,
> -	[7] = &llc_adm_state_trans_4,
> -	[8] = &llc_adm_state_trans_5,
> -	[9] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_SETUP transitions */
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_setup_actions_1[] = {
> -	[0] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[1] = llc_conn_ac_set_vs_0,
> -	[2] = llc_conn_ac_set_vr_0,
> -	[3] = llc_conn_ac_set_s_flag_1,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_1 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_SETUP,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_setup_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_setup_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = llc_conn_ev_qlfy_set_status_conn,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_setup_actions_2[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_ac_set_vs_0,
> -	[2] = llc_conn_ac_set_vr_0,
> -	[3] = llc_conn_ac_upd_p_flag,
> -	[4] = llc_conn_ac_set_remote_busy_0,
> -	[5] = llc_conn_ac_conn_confirm,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_setup_ev_qfyrs_2,
> -	.ev_actions    = llc_setup_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_setup_ev_qfyrs_3[] = {
> -	[0] = llc_conn_ev_qlfy_s_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_conn,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_setup_actions_3[] = {
> -	[0] = llc_conn_ac_set_p_flag_0,
> -	[1] = llc_conn_ac_set_remote_busy_0,
> -	[2] = llc_conn_ac_conn_confirm,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_3 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_setup_ev_qfyrs_3,
> -	.ev_actions    = llc_setup_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_setup_ev_qfyrs_4[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_disc,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_setup_actions_4[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
> -	[1] = llc_conn_ac_stop_ack_timer,
> -	[2] = llc_conn_ac_conn_confirm,
> -	[3] = llc_conn_disc,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_setup_ev_qfyrs_4,
> -	.ev_actions    = llc_setup_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_setup_ev_qfyrs_5[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_disc,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_setup_actions_5[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_ac_conn_confirm,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_5 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_setup_ev_qfyrs_5,
> -	.ev_actions    = llc_setup_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_setup_ev_qfyrs_7[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = llc_conn_ev_qlfy_s_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_setup_actions_7[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_7 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_SETUP,
> -	.ev_qualifiers = llc_setup_ev_qfyrs_7,
> -	.ev_actions    = llc_setup_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_setup_ev_qfyrs_8[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = llc_conn_ev_qlfy_s_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_set_status_failed,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_setup_actions_8[] = {
> -	[0] = llc_conn_ac_conn_confirm,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_setup_state_trans_8 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_setup_ev_qfyrs_8,
> -	.ev_actions    = llc_setup_actions_8,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_setup_state_transitions[] = {
> -	 [0] = &llc_common_state_trans_end,	/* Request */
> -	 [1] = &llc_common_state_trans_end,	/* local busy */
> -	 [2] = &llc_common_state_trans_end,	/* init_pf_cycle */
> -	 [3] = &llc_setup_state_trans_3,	/* Timer */
> -	 [4] = &llc_setup_state_trans_7,
> -	 [5] = &llc_setup_state_trans_8,
> -	 [6] = &llc_common_state_trans_end,
> -	 [7] = &llc_setup_state_trans_1,	/* Receive frame */
> -	 [8] = &llc_setup_state_trans_2,
> -	 [9] = &llc_setup_state_trans_4,
> -	[10] = &llc_setup_state_trans_5,
> -	[11] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_NORMAL transitions */
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_1[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_last_frame_eq_0,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_1[] = {
> -	[0] = llc_conn_ac_send_i_as_ack,
> -	[1] = llc_conn_ac_start_ack_tmr_if_not_running,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_1 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_1,
> -	.ev_actions    = llc_normal_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_last_frame_eq_1,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_2[] = {
> -	[0] = llc_conn_ac_send_i_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_2 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_2,
> -	.ev_actions    = llc_normal_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_2_1[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_remote_busy,
> -	[2] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_normal_actions_2_1[1];
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_2_1 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_2_1,
> -	.ev_actions    = llc_normal_actions_2_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_DETECTED event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_3[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_3[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rnr_xxx_x_set_0,
> -	[2] = llc_conn_ac_set_data_flag_0,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_3 = {
> -	.ev	       = llc_conn_ev_local_busy_detected,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_3,
> -	.ev_actions    = llc_normal_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_DETECTED event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_4[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_4[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rnr_xxx_x_set_0,
> -	[2] = llc_conn_ac_set_data_flag_0,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_4 = {
> -	.ev	       = llc_conn_ev_local_busy_detected,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_4,
> -	.ev_actions    = llc_normal_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_5a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_5a[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_upd_p_flag,
> -	[4] = llc_conn_ac_start_rej_timer,
> -	[5] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_5a = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_5a,
> -	.ev_actions    = llc_normal_actions_5a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_5b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_5b[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_upd_p_flag,
> -	[4] = llc_conn_ac_start_rej_timer,
> -	[5] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_5b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_5b,
> -	.ev_actions    = llc_normal_actions_5b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_5c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_5c[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_upd_p_flag,
> -	[4] = llc_conn_ac_start_rej_timer,
> -	[5] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_5c = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_5c,
> -	.ev_actions    = llc_normal_actions_5c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_6a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_6a[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_start_rej_timer,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_6a = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_6a,
> -	.ev_actions    = llc_normal_actions_6a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_6b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_6b[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_start_rej_timer,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_6b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_6b,
> -	.ev_actions    = llc_normal_actions_6b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_normal_actions_7[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rej_rsp_f_set_1,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_start_rej_timer,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_7 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_8a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_8[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[5] = llc_conn_ac_send_ack_if_needed,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_8a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_8a,
> -	.ev_actions    = llc_normal_actions_8,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_8b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_8b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_8b,
> -	.ev_actions    = llc_normal_actions_8,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_9a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_9a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_data_ind,
> -	[3] = llc_conn_ac_send_ack_if_needed,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_9a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_9a,
> -	.ev_actions    = llc_normal_actions_9a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_9b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_9b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_data_ind,
> -	[3] = llc_conn_ac_send_ack_if_needed,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_9b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_9b,
> -	.ev_actions    = llc_normal_actions_9b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_normal_actions_10[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_send_ack_rsp_f_set_1,
> -	[2] = llc_conn_ac_rst_sendack_flag,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_data_ind,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_10 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_10,
> -};
> -
> -/* State transitions for * LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_normal_actions_11a[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_11a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_11a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_normal_actions_11b[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_11b = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_11b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_11c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_11c[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_inc_tx_win_size,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_11c = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_11c,
> -	.ev_actions    = llc_normal_actions_11c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_normal_actions_12[] = {
> -	[0] = llc_conn_ac_send_ack_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_adjust_npta_by_rr,
> -	[3] = llc_conn_ac_rst_sendack_flag,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_12 = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_12,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_normal_actions_13a[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_13a = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_13a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_normal_actions_13b[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_13b = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_13b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_13c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_13c[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_13c = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_13c,
> -	.ev_actions    = llc_normal_actions_13c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_normal_actions_14[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_adjust_npta_by_rnr,
> -	[3] = llc_conn_ac_rst_sendack_flag,
> -	[4] = llc_conn_ac_set_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_14 = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_14,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_15a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_15a[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_dec_tx_win_size,
> -	[4] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[5] = llc_conn_ac_clear_remote_busy,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_15a = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_15a,
> -	.ev_actions    = llc_normal_actions_15a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_15b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_15b[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_dec_tx_win_size,
> -	[4] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[5] = llc_conn_ac_clear_remote_busy,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_15b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_15b,
> -	.ev_actions    = llc_normal_actions_15b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_16a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_16a[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_dec_tx_win_size,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_16a = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_16a,
> -	.ev_actions    = llc_normal_actions_16a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_16b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_16b[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_dec_tx_win_size,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_16b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_16b,
> -	.ev_actions    = llc_normal_actions_16b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_normal_actions_17[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_dec_tx_win_size,
> -	[3] = llc_conn_ac_resend_i_rsp_f_set_1,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_17 = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_normal_actions_17,
> -};
> -
> -/* State transitions for LLC_CONN_EV_INIT_P_F_CYCLE event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_18[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_18[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_18 = {
> -	.ev	       = llc_conn_ev_init_p_f_cycle,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_18,
> -	.ev_actions    = llc_normal_actions_18,
> -};
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_19[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_19[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[2] = llc_conn_ac_rst_vs,
> -	[3] = llc_conn_ac_start_p_timer,
> -	[4] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_19 = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_19,
> -	.ev_actions    = llc_normal_actions_19,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_20a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_20a[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[2] = llc_conn_ac_rst_vs,
> -	[3] = llc_conn_ac_start_p_timer,
> -	[4] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_20a = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_20a,
> -	.ev_actions    = llc_normal_actions_20a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_BUSY_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_20b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_20b[] = {
> -	[0] = llc_conn_ac_rst_sendack_flag,
> -	[1] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[2] = llc_conn_ac_rst_vs,
> -	[3] = llc_conn_ac_start_p_timer,
> -	[4] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_20b = {
> -	.ev	       = llc_conn_ev_busy_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_20b,
> -	.ev_actions    = llc_normal_actions_20b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_TX_BUFF_FULL event */
> -static const llc_conn_ev_qfyr_t llc_normal_ev_qfyrs_21[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_normal_actions_21[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_normal_state_trans_21 = {
> -	.ev	       = llc_conn_ev_tx_buffer_full,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_normal_ev_qfyrs_21,
> -	.ev_actions    = llc_normal_actions_21,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_normal_state_transitions[] = {
> -	 [0] = &llc_normal_state_trans_1,	/* Requests */
> -	 [1] = &llc_normal_state_trans_2,
> -	 [2] = &llc_normal_state_trans_2_1,
> -	 [3] = &llc_common_state_trans_1,
> -	 [4] = &llc_common_state_trans_2,
> -	 [5] = &llc_common_state_trans_end,
> -	 [6] = &llc_normal_state_trans_21,
> -	 [7] = &llc_normal_state_trans_3,	/* Local busy */
> -	 [8] = &llc_normal_state_trans_4,
> -	 [9] = &llc_common_state_trans_end,
> -	[10] = &llc_normal_state_trans_18,	/* Init pf cycle */
> -	[11] = &llc_common_state_trans_end,
> -	[12] = &llc_common_state_trans_11a,	/* Timers */
> -	[13] = &llc_common_state_trans_11b,
> -	[14] = &llc_common_state_trans_11c,
> -	[15] = &llc_common_state_trans_11d,
> -	[16] = &llc_normal_state_trans_19,
> -	[17] = &llc_normal_state_trans_20a,
> -	[18] = &llc_normal_state_trans_20b,
> -	[19] = &llc_common_state_trans_end,
> -	[20] = &llc_normal_state_trans_8b,	/* Receive frames */
> -	[21] = &llc_normal_state_trans_9b,
> -	[22] = &llc_normal_state_trans_10,
> -	[23] = &llc_normal_state_trans_11b,
> -	[24] = &llc_normal_state_trans_11c,
> -	[25] = &llc_normal_state_trans_5a,
> -	[26] = &llc_normal_state_trans_5b,
> -	[27] = &llc_normal_state_trans_5c,
> -	[28] = &llc_normal_state_trans_6a,
> -	[29] = &llc_normal_state_trans_6b,
> -	[30] = &llc_normal_state_trans_7,
> -	[31] = &llc_normal_state_trans_8a,
> -	[32] = &llc_normal_state_trans_9a,
> -	[33] = &llc_normal_state_trans_11a,
> -	[34] = &llc_normal_state_trans_12,
> -	[35] = &llc_normal_state_trans_13a,
> -	[36] = &llc_normal_state_trans_13b,
> -	[37] = &llc_normal_state_trans_13c,
> -	[38] = &llc_normal_state_trans_14,
> -	[39] = &llc_normal_state_trans_15a,
> -	[40] = &llc_normal_state_trans_15b,
> -	[41] = &llc_normal_state_trans_16a,
> -	[42] = &llc_normal_state_trans_16b,
> -	[43] = &llc_normal_state_trans_17,
> -	[44] = &llc_common_state_trans_3,
> -	[45] = &llc_common_state_trans_4,
> -	[46] = &llc_common_state_trans_5,
> -	[47] = &llc_common_state_trans_6,
> -	[48] = &llc_common_state_trans_7a,
> -	[49] = &llc_common_state_trans_7b,
> -	[50] = &llc_common_state_trans_8a,
> -	[51] = &llc_common_state_trans_8b,
> -	[52] = &llc_common_state_trans_8c,
> -	[53] = &llc_common_state_trans_9,
> -	/* [54] = &llc_common_state_trans_10, */
> -	[54] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_BUSY transitions */
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_1[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_1[] = {
> -	[0] = llc_conn_ac_send_i_xxx_x_set_0,
> -	[1] = llc_conn_ac_start_ack_tmr_if_not_running,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_1 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_1,
> -	.ev_actions    = llc_busy_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_2[] = {
> -	[0] = llc_conn_ac_send_i_xxx_x_set_0,
> -	[1] = llc_conn_ac_start_ack_tmr_if_not_running,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_2 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_2,
> -	.ev_actions    = llc_busy_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_2_1[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_remote_busy,
> -	[2] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_busy_actions_2_1[1];
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_2_1 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_2_1,
> -	.ev_actions    = llc_busy_actions_2_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_3[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_3[] = {
> -	[0] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[1] = llc_conn_ac_start_rej_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_3 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_3,
> -	.ev_actions    = llc_busy_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_4[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_4[] = {
> -	[0] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[1] = llc_conn_ac_start_rej_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_4 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_4,
> -	.ev_actions    = llc_busy_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_5[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_5[] = {
> -	[0] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_5 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_5,
> -	.ev_actions    = llc_busy_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_6[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_6[] = {
> -	[0] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_6 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_6,
> -	.ev_actions    = llc_busy_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_7[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_2,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_7[] = {
> -	[0] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_7 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_7,
> -	.ev_actions    = llc_busy_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_8[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_2,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_8[] = {
> -	[0] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_8 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_8,
> -	.ev_actions    = llc_busy_actions_8,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_X_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_9a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_9a[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_p_flag,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_set_data_flag_1_if_data_flag_eq_0,
> -	[4] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_9a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_9a,
> -	.ev_actions    = llc_busy_actions_9a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_9b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_9b[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_p_flag,
> -	[2] = llc_conn_ac_upd_nr_received,
> -	[3] = llc_conn_ac_set_data_flag_1_if_data_flag_eq_0,
> -	[4] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_9b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_9b,
> -	.ev_actions    = llc_busy_actions_9b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_10a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_10a[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_data_flag_1_if_data_flag_eq_0,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_10a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_10a,
> -	.ev_actions    = llc_busy_actions_10a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_10b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_10b[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_data_flag_1_if_data_flag_eq_0,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_10b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_10b,
> -	.ev_actions    = llc_busy_actions_10b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_busy_actions_11[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_data_flag_1_if_data_flag_eq_0,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_11 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_11,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_busy_actions_12[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2,
> -	[5] = llc_conn_ac_set_data_flag_0,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_12 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_12,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_13a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_13a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2,
> -	[6] = llc_conn_ac_set_data_flag_0,
> -	[7] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[8] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_13a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_13a,
> -	.ev_actions    = llc_busy_actions_13a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_13b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_13b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2,
> -	[6] = llc_conn_ac_set_data_flag_0,
> -	[7] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[8] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_13b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_13b,
> -	.ev_actions    = llc_busy_actions_13b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_14a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_14a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2,
> -	[5] = llc_conn_ac_set_data_flag_0,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_14a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_14a,
> -	.ev_actions    = llc_busy_actions_14a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_14b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_14b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2,
> -	[5] = llc_conn_ac_set_data_flag_0,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_14b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_14b,
> -	.ev_actions    = llc_busy_actions_14b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_busy_actions_15a[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_15a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_15a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_busy_actions_15b[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_15b = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_15b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_15c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_15c[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_15c = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_15c,
> -	.ev_actions    = llc_busy_actions_15c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_busy_actions_16[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_16 = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_16,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_busy_actions_17a[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_17a = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_17a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_busy_actions_17b[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_17b = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_17b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_17c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_17c[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_17c = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_17c,
> -	.ev_actions    = llc_busy_actions_17c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_busy_actions_18[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_18 = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_18,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_19a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_19a[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_19a = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_19a,
> -	.ev_actions    = llc_busy_actions_19a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_19b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_19b[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_19b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_19b,
> -	.ev_actions    = llc_busy_actions_19b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_20a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_20a[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_20a = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_20a,
> -	.ev_actions    = llc_busy_actions_20a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_20b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_20b[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_20b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_20b,
> -	.ev_actions    = llc_busy_actions_20b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_busy_actions_21[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_21 = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_busy_actions_21,
> -};
> -
> -/* State transitions for LLC_CONN_EV_INIT_P_F_CYCLE event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_22[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_22[] = {
> -	[0] = llc_conn_ac_send_rnr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_22 = {
> -	.ev	       = llc_conn_ev_init_p_f_cycle,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_22,
> -	.ev_actions    = llc_busy_actions_22,
> -};
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_23[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_23[] = {
> -	[0] = llc_conn_ac_send_rnr_cmd_p_set_1,
> -	[1] = llc_conn_ac_rst_vs,
> -	[2] = llc_conn_ac_start_p_timer,
> -	[3] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_23 = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_23,
> -	.ev_actions    = llc_busy_actions_23,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_24a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_24a[] = {
> -	[0] = llc_conn_ac_send_rnr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = llc_conn_ac_rst_vs,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_24a = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_24a,
> -	.ev_actions    = llc_busy_actions_24a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_BUSY_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_24b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_24b[] = {
> -	[0] = llc_conn_ac_send_rnr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = llc_conn_ac_rst_vs,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_24b = {
> -	.ev	       = llc_conn_ev_busy_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_24b,
> -	.ev_actions    = llc_busy_actions_24b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_REJ_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_25[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_25[] = {
> -	[0] = llc_conn_ac_send_rnr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = llc_conn_ac_rst_vs,
> -	[4] = llc_conn_ac_set_data_flag_1,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_25 = {
> -	.ev	       = llc_conn_ev_rej_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_25,
> -	.ev_actions    = llc_busy_actions_25,
> -};
> -
> -/* State transitions for LLC_CONN_EV_REJ_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_busy_ev_qfyrs_26[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_busy_actions_26[] = {
> -	[0] = llc_conn_ac_set_data_flag_1,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_busy_state_trans_26 = {
> -	.ev	       = llc_conn_ev_rej_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_busy_ev_qfyrs_26,
> -	.ev_actions    = llc_busy_actions_26,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_busy_state_transitions[] = {
> -	 [0] = &llc_common_state_trans_1,	/* Request */
> -	 [1] = &llc_common_state_trans_2,
> -	 [2] = &llc_busy_state_trans_1,
> -	 [3] = &llc_busy_state_trans_2,
> -	 [4] = &llc_busy_state_trans_2_1,
> -	 [5] = &llc_common_state_trans_end,
> -	 [6] = &llc_busy_state_trans_3,		/* Local busy */
> -	 [7] = &llc_busy_state_trans_4,
> -	 [8] = &llc_busy_state_trans_5,
> -	 [9] = &llc_busy_state_trans_6,
> -	[10] = &llc_busy_state_trans_7,
> -	[11] = &llc_busy_state_trans_8,
> -	[12] = &llc_common_state_trans_end,
> -	[13] = &llc_busy_state_trans_22,	/* Initiate PF cycle */
> -	[14] = &llc_common_state_trans_end,
> -	[15] = &llc_common_state_trans_11a,	/* Timer */
> -	[16] = &llc_common_state_trans_11b,
> -	[17] = &llc_common_state_trans_11c,
> -	[18] = &llc_common_state_trans_11d,
> -	[19] = &llc_busy_state_trans_23,
> -	[20] = &llc_busy_state_trans_24a,
> -	[21] = &llc_busy_state_trans_24b,
> -	[22] = &llc_busy_state_trans_25,
> -	[23] = &llc_busy_state_trans_26,
> -	[24] = &llc_common_state_trans_end,
> -	[25] = &llc_busy_state_trans_9a,	/* Receive frame */
> -	[26] = &llc_busy_state_trans_9b,
> -	[27] = &llc_busy_state_trans_10a,
> -	[28] = &llc_busy_state_trans_10b,
> -	[29] = &llc_busy_state_trans_11,
> -	[30] = &llc_busy_state_trans_12,
> -	[31] = &llc_busy_state_trans_13a,
> -	[32] = &llc_busy_state_trans_13b,
> -	[33] = &llc_busy_state_trans_14a,
> -	[34] = &llc_busy_state_trans_14b,
> -	[35] = &llc_busy_state_trans_15a,
> -	[36] = &llc_busy_state_trans_15b,
> -	[37] = &llc_busy_state_trans_15c,
> -	[38] = &llc_busy_state_trans_16,
> -	[39] = &llc_busy_state_trans_17a,
> -	[40] = &llc_busy_state_trans_17b,
> -	[41] = &llc_busy_state_trans_17c,
> -	[42] = &llc_busy_state_trans_18,
> -	[43] = &llc_busy_state_trans_19a,
> -	[44] = &llc_busy_state_trans_19b,
> -	[45] = &llc_busy_state_trans_20a,
> -	[46] = &llc_busy_state_trans_20b,
> -	[47] = &llc_busy_state_trans_21,
> -	[48] = &llc_common_state_trans_3,
> -	[49] = &llc_common_state_trans_4,
> -	[50] = &llc_common_state_trans_5,
> -	[51] = &llc_common_state_trans_6,
> -	[52] = &llc_common_state_trans_7a,
> -	[53] = &llc_common_state_trans_7b,
> -	[54] = &llc_common_state_trans_8a,
> -	[55] = &llc_common_state_trans_8b,
> -	[56] = &llc_common_state_trans_8c,
> -	[57] = &llc_common_state_trans_9,
> -	/* [58] = &llc_common_state_trans_10, */
> -	[58] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_REJ transitions */
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_1[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_1[] = {
> -	[0] = llc_conn_ac_send_i_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_1 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_1,
> -	.ev_actions    = llc_reject_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_0,
> -	[1] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_2[] = {
> -	[0] = llc_conn_ac_send_i_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_2 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_2,
> -	.ev_actions    = llc_reject_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_2_1[] = {
> -	[0] = llc_conn_ev_qlfy_remote_busy_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_remote_busy,
> -	[2] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_reject_actions_2_1[1];
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_2_1 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_2_1,
> -	.ev_actions    = llc_reject_actions_2_1,
> -};
> -
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_DETECTED event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_3[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_3[] = {
> -	[0] = llc_conn_ac_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_set_data_flag_2,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_3 = {
> -	.ev	       = llc_conn_ev_local_busy_detected,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_3,
> -	.ev_actions    = llc_reject_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_DETECTED event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_4[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_4[] = {
> -	[0] = llc_conn_ac_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_set_data_flag_2,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_4 = {
> -	.ev	       = llc_conn_ev_local_busy_detected,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_4,
> -	.ev_actions    = llc_reject_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_reject_actions_5a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_p_flag,
> -	[2] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_5a = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_5a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_reject_actions_5b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_p_flag,
> -	[2] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_5b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_5b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_5c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_5c[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_p_flag,
> -	[2] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_5c = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_5c,
> -	.ev_actions    = llc_reject_actions_5c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_reject_actions_6[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_6 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_7a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_7a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_send_ack_xxx_x_set_0,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[6] = llc_conn_ac_stop_rej_timer,
> -	[7] = NULL,
> -
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_7a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_7a,
> -	.ev_actions    = llc_reject_actions_7a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_7b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_7b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_send_ack_xxx_x_set_0,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_clear_remote_busy_if_f_eq_1,
> -	[6] = llc_conn_ac_stop_rej_timer,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_7b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_7b,
> -	.ev_actions    = llc_reject_actions_7b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_8a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_8a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_ack_xxx_x_set_0,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_stop_rej_timer,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_8a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_8a,
> -	.ev_actions    = llc_reject_actions_8a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_8b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_8b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_ack_xxx_x_set_0,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_stop_rej_timer,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_8b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_8b,
> -	.ev_actions    = llc_reject_actions_8b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_reject_actions_9[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_ack_rsp_f_set_1,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_stop_rej_timer,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_9 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_9,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_reject_actions_10a[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_10a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_10a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_reject_actions_10b[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_10b = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_10b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_10c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_10c[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_10c = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_10c,
> -	.ev_actions    = llc_reject_actions_10c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_reject_actions_11[] = {
> -	[0] = llc_conn_ac_send_ack_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_11 = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_11,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_reject_actions_12a[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_12a = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_12a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_reject_actions_12b[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_12b = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_12b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_12c[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_12c[] = {
> -	[0] = llc_conn_ac_upd_p_flag,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_12c = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_12c,
> -	.ev_actions    = llc_reject_actions_12c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_reject_actions_13[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_13 = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_13,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_14a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_14a[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_14a = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_14a,
> -	.ev_actions    = llc_reject_actions_14a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_X event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_14b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_14b[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_p_flag,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_14b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_14b,
> -	.ev_actions    = llc_reject_actions_14b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_15a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_15a[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_15a = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_15a,
> -	.ev_actions    = llc_reject_actions_15a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0 event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_15b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_15b[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_15b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_15b,
> -	.ev_actions    = llc_reject_actions_15b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_reject_actions_16[] = {
> -	[0] = llc_conn_ac_set_vs_nr,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_resend_i_rsp_f_set_1,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_16 = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_reject_actions_16,
> -};
> -
> -/* State transitions for LLC_CONN_EV_INIT_P_F_CYCLE event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_17[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_17[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_17 = {
> -	.ev	       = llc_conn_ev_init_p_f_cycle,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_17,
> -	.ev_actions    = llc_reject_actions_17,
> -};
> -
> -/* State transitions for LLC_CONN_EV_REJ_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_18[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_18[] = {
> -	[0] = llc_conn_ac_send_rej_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_start_rej_timer,
> -	[3] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_18 = {
> -	.ev	       = llc_conn_ev_rej_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_18,
> -	.ev_actions    = llc_reject_actions_18,
> -};
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_19[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_19[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_start_rej_timer,
> -	[3] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[4] = llc_conn_ac_rst_vs,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_19 = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_19,
> -	.ev_actions    = llc_reject_actions_19,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_20a[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_20a[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_start_rej_timer,
> -	[3] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[4] = llc_conn_ac_rst_vs,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_20a = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_20a,
> -	.ev_actions    = llc_reject_actions_20a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_BUSY_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_reject_ev_qfyrs_20b[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_reject_actions_20b[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_start_rej_timer,
> -	[3] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[4] = llc_conn_ac_rst_vs,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_reject_state_trans_20b = {
> -	.ev	       = llc_conn_ev_busy_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_reject_ev_qfyrs_20b,
> -	.ev_actions    = llc_reject_actions_20b,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_reject_state_transitions[] = {
> -	 [0] = &llc_common_state_trans_1,	/* Request */
> -	 [1] = &llc_common_state_trans_2,
> -	 [2] = &llc_common_state_trans_end,
> -	 [3] = &llc_reject_state_trans_1,
> -	 [4] = &llc_reject_state_trans_2,
> -	 [5] = &llc_reject_state_trans_2_1,
> -	 [6] = &llc_reject_state_trans_3,	/* Local busy */
> -	 [7] = &llc_reject_state_trans_4,
> -	 [8] = &llc_common_state_trans_end,
> -	 [9] = &llc_reject_state_trans_17,	/* Initiate PF cycle */
> -	[10] = &llc_common_state_trans_end,
> -	[11] = &llc_common_state_trans_11a,	/* Timer */
> -	[12] = &llc_common_state_trans_11b,
> -	[13] = &llc_common_state_trans_11c,
> -	[14] = &llc_common_state_trans_11d,
> -	[15] = &llc_reject_state_trans_18,
> -	[16] = &llc_reject_state_trans_19,
> -	[17] = &llc_reject_state_trans_20a,
> -	[18] = &llc_reject_state_trans_20b,
> -	[19] = &llc_common_state_trans_end,
> -	[20] = &llc_common_state_trans_3,	/* Receive frame */
> -	[21] = &llc_common_state_trans_4,
> -	[22] = &llc_common_state_trans_5,
> -	[23] = &llc_common_state_trans_6,
> -	[24] = &llc_common_state_trans_7a,
> -	[25] = &llc_common_state_trans_7b,
> -	[26] = &llc_common_state_trans_8a,
> -	[27] = &llc_common_state_trans_8b,
> -	[28] = &llc_common_state_trans_8c,
> -	[29] = &llc_common_state_trans_9,
> -	/* [30] = &llc_common_state_trans_10, */
> -	[30] = &llc_reject_state_trans_5a,
> -	[31] = &llc_reject_state_trans_5b,
> -	[32] = &llc_reject_state_trans_5c,
> -	[33] = &llc_reject_state_trans_6,
> -	[34] = &llc_reject_state_trans_7a,
> -	[35] = &llc_reject_state_trans_7b,
> -	[36] = &llc_reject_state_trans_8a,
> -	[37] = &llc_reject_state_trans_8b,
> -	[38] = &llc_reject_state_trans_9,
> -	[39] = &llc_reject_state_trans_10a,
> -	[40] = &llc_reject_state_trans_10b,
> -	[41] = &llc_reject_state_trans_10c,
> -	[42] = &llc_reject_state_trans_11,
> -	[43] = &llc_reject_state_trans_12a,
> -	[44] = &llc_reject_state_trans_12b,
> -	[45] = &llc_reject_state_trans_12c,
> -	[46] = &llc_reject_state_trans_13,
> -	[47] = &llc_reject_state_trans_14a,
> -	[48] = &llc_reject_state_trans_14b,
> -	[49] = &llc_reject_state_trans_15a,
> -	[50] = &llc_reject_state_trans_15b,
> -	[51] = &llc_reject_state_trans_16,
> -	[52] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_AWAIT transitions */
> -/* State transitions for LLC_CONN_EV_DATA_REQ event */
> -static const llc_conn_ev_qfyr_t llc_await_ev_qfyrs_1_0[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_refuse,
> -	[1] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_await_actions_1_0[1];
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_1_0 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = llc_await_ev_qfyrs_1_0,
> -	.ev_actions    = llc_await_actions_1_0,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_DETECTED event */
> -static const llc_conn_action_t llc_await_actions_1[] = {
> -	[0] = llc_conn_ac_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_set_data_flag_0,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_1 = {
> -	.ev	       = llc_conn_ev_local_busy_detected,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_actions_2[] = {
> -	[0] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_stop_p_timer,
> -	[4] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[5] = llc_conn_ac_start_rej_timer,
> -	[6] = llc_conn_ac_clear_remote_busy,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_actions_3a[] = {
> -	[0] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_start_rej_timer,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_3a = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_3a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_actions_3b[] = {
> -	[0] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_start_rej_timer,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_3b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_3b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_actions_4[] = {
> -	[0] = llc_conn_ac_send_rej_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_start_rej_timer,
> -	[4] = llc_conn_ac_start_p_timer,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_5[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr,
> -	[6] = llc_conn_ac_clear_remote_busy,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_5 = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_6a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_6a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_6a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_6b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_6b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_6b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_7[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_7 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_8a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_8a = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_8a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_8b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_8b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_8b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_9a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_9a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_9a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_9b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_9b = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_9b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_9c[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_9c = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_9c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_9d[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_9d = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_9d,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_10a[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_10a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_10a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_10b[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_10b = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_10b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_11[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_set_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_11 = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_11,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_12a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_12a = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_12a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_actions_12b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_12b = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_12b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_actions_13[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_set_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_13 = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_actions_13,
> -};
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_await_ev_qfyrs_14[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_await_actions_14[] = {
> -	[0] = llc_conn_ac_send_rr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_state_trans_14 = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = llc_await_ev_qfyrs_14,
> -	.ev_actions    = llc_await_actions_14,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_await_state_transitions[] = {
> -	 [0] = &llc_common_state_trans_1,	/* Request */
> -	 [1] = &llc_common_state_trans_2,
> -	 [2] = &llc_await_state_trans_1_0,
> -	 [3] = &llc_common_state_trans_end,
> -	 [4] = &llc_await_state_trans_1,	/* Local busy */
> -	 [5] = &llc_common_state_trans_end,
> -	 [6] = &llc_common_state_trans_end,	/* Initiate PF Cycle */
> -	 [7] = &llc_common_state_trans_11a,	/* Timer */
> -	 [8] = &llc_common_state_trans_11b,
> -	 [9] = &llc_common_state_trans_11c,
> -	[10] = &llc_common_state_trans_11d,
> -	[11] = &llc_await_state_trans_14,
> -	[12] = &llc_common_state_trans_end,
> -	[13] = &llc_common_state_trans_3,	/* Receive frame */
> -	[14] = &llc_common_state_trans_4,
> -	[15] = &llc_common_state_trans_5,
> -	[16] = &llc_common_state_trans_6,
> -	[17] = &llc_common_state_trans_7a,
> -	[18] = &llc_common_state_trans_7b,
> -	[19] = &llc_common_state_trans_8a,
> -	[20] = &llc_common_state_trans_8b,
> -	[21] = &llc_common_state_trans_8c,
> -	[22] = &llc_common_state_trans_9,
> -	/* [23] = &llc_common_state_trans_10, */
> -	[23] = &llc_await_state_trans_2,
> -	[24] = &llc_await_state_trans_3a,
> -	[25] = &llc_await_state_trans_3b,
> -	[26] = &llc_await_state_trans_4,
> -	[27] = &llc_await_state_trans_5,
> -	[28] = &llc_await_state_trans_6a,
> -	[29] = &llc_await_state_trans_6b,
> -	[30] = &llc_await_state_trans_7,
> -	[31] = &llc_await_state_trans_8a,
> -	[32] = &llc_await_state_trans_8b,
> -	[33] = &llc_await_state_trans_9a,
> -	[34] = &llc_await_state_trans_9b,
> -	[35] = &llc_await_state_trans_9c,
> -	[36] = &llc_await_state_trans_9d,
> -	[37] = &llc_await_state_trans_10a,
> -	[38] = &llc_await_state_trans_10b,
> -	[39] = &llc_await_state_trans_11,
> -	[40] = &llc_await_state_trans_12a,
> -	[41] = &llc_await_state_trans_12b,
> -	[42] = &llc_await_state_trans_13,
> -	[43] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_AWAIT_BUSY transitions */
> -/* State transitions for LLC_CONN_EV_DATA_CONN_REQ event */
> -static const llc_conn_ev_qfyr_t llc_await_busy_ev_qfyrs_1_0[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_refuse,
> -	[1] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_await_busy_actions_1_0[1];
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_1_0 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = llc_await_busy_ev_qfyrs_1_0,
> -	.ev_actions    = llc_await_busy_actions_1_0,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_await_busy_ev_qfyrs_1[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_1,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_await_busy_actions_1[] = {
> -	[0] = llc_conn_ac_send_rej_xxx_x_set_0,
> -	[1] = llc_conn_ac_start_rej_timer,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_1 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_await_busy_ev_qfyrs_1,
> -	.ev_actions    = llc_await_busy_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_await_busy_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_0,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_await_busy_actions_2[] = {
> -	[0] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_2 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = llc_await_busy_ev_qfyrs_2,
> -	.ev_actions    = llc_await_busy_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_CLEARED event */
> -static const llc_conn_ev_qfyr_t llc_await_busy_ev_qfyrs_3[] = {
> -	[0] = llc_conn_ev_qlfy_data_flag_eq_2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_await_busy_actions_3[] = {
> -	[0] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_3 = {
> -	.ev	       = llc_conn_ev_local_busy_cleared,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_await_busy_ev_qfyrs_3,
> -	.ev_actions    = llc_await_busy_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_busy_actions_4[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_stop_p_timer,
> -	[4] = llc_conn_ac_set_data_flag_1,
> -	[5] = llc_conn_ac_clear_remote_busy,
> -	[6] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_busy_actions_5a[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_set_data_flag_1,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_5a = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_5a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_busy_actions_5b[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_set_data_flag_1,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_5b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_5b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_busy_actions_6[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_set_data_flag_1,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_6 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_7[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_inc_vr_by_1,
> -	[2] = llc_conn_ac_data_ind,
> -	[3] = llc_conn_ac_stop_p_timer,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_upd_vs,
> -	[6] = llc_conn_ac_set_data_flag_0,
> -	[7] = llc_conn_ac_clear_remote_busy,
> -	[8] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[9] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_7 = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_8a[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_inc_vr_by_1,
> -	[2] = llc_conn_ac_data_ind,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = llc_conn_ac_set_data_flag_0,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_8a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_8a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_8b[] = {
> -	[0] = llc_conn_ac_opt_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_inc_vr_by_1,
> -	[2] = llc_conn_ac_data_ind,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = llc_conn_ac_set_data_flag_0,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_8b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_8b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_9[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_inc_vr_by_1,
> -	[2] = llc_conn_ac_data_ind,
> -	[3] = llc_conn_ac_upd_nr_received,
> -	[4] = llc_conn_ac_upd_vs,
> -	[5] = llc_conn_ac_set_data_flag_0,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_9 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_9,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_10a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_10a = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_10a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_10b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_10b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_10b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_11a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_11a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_11a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_11b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_11b = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_11b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_11c[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_11c = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_11c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_11d[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_11d = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_11d,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_12a[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_12a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_12a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_12b[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_12b = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_12b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_13[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_set_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_13 = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_13,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_14a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_14a = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_14a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_busy_actions_14b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_14b = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_14b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_busy_actions_15[] = {
> -	[0] = llc_conn_ac_send_rnr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_set_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_15 = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_busy_actions_15,
> -};
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_await_busy_ev_qfyrs_16[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_await_busy_actions_16[] = {
> -	[0] = llc_conn_ac_send_rnr_cmd_p_set_1,
> -	[1] = llc_conn_ac_start_p_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_busy_state_trans_16 = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = llc_await_busy_ev_qfyrs_16,
> -	.ev_actions    = llc_await_busy_actions_16,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_await_busy_state_transitions[] = {
> -	 [0] = &llc_common_state_trans_1,		/* Request */
> -	 [1] = &llc_common_state_trans_2,
> -	 [2] = &llc_await_busy_state_trans_1_0,
> -	 [3] = &llc_common_state_trans_end,
> -	 [4] = &llc_await_busy_state_trans_1,		/* Local busy */
> -	 [5] = &llc_await_busy_state_trans_2,
> -	 [6] = &llc_await_busy_state_trans_3,
> -	 [7] = &llc_common_state_trans_end,
> -	 [8] = &llc_common_state_trans_end,		/* Initiate PF cycle */
> -	 [9] = &llc_common_state_trans_11a,		/* Timer */
> -	[10] = &llc_common_state_trans_11b,
> -	[11] = &llc_common_state_trans_11c,
> -	[12] = &llc_common_state_trans_11d,
> -	[13] = &llc_await_busy_state_trans_16,
> -	[14] = &llc_common_state_trans_end,
> -	[15] = &llc_await_busy_state_trans_4,		/* Receive frame */
> -	[16] = &llc_await_busy_state_trans_5a,
> -	[17] = &llc_await_busy_state_trans_5b,
> -	[18] = &llc_await_busy_state_trans_6,
> -	[19] = &llc_await_busy_state_trans_7,
> -	[20] = &llc_await_busy_state_trans_8a,
> -	[21] = &llc_await_busy_state_trans_8b,
> -	[22] = &llc_await_busy_state_trans_9,
> -	[23] = &llc_await_busy_state_trans_10a,
> -	[24] = &llc_await_busy_state_trans_10b,
> -	[25] = &llc_await_busy_state_trans_11a,
> -	[26] = &llc_await_busy_state_trans_11b,
> -	[27] = &llc_await_busy_state_trans_11c,
> -	[28] = &llc_await_busy_state_trans_11d,
> -	[29] = &llc_await_busy_state_trans_12a,
> -	[30] = &llc_await_busy_state_trans_12b,
> -	[31] = &llc_await_busy_state_trans_13,
> -	[32] = &llc_await_busy_state_trans_14a,
> -	[33] = &llc_await_busy_state_trans_14b,
> -	[34] = &llc_await_busy_state_trans_15,
> -	[35] = &llc_common_state_trans_3,
> -	[36] = &llc_common_state_trans_4,
> -	[37] = &llc_common_state_trans_5,
> -	[38] = &llc_common_state_trans_6,
> -	[39] = &llc_common_state_trans_7a,
> -	[40] = &llc_common_state_trans_7b,
> -	[41] = &llc_common_state_trans_8a,
> -	[42] = &llc_common_state_trans_8b,
> -	[43] = &llc_common_state_trans_8c,
> -	[44] = &llc_common_state_trans_9,
> -	/* [45] = &llc_common_state_trans_10, */
> -	[45] = &llc_common_state_trans_end,
> -};
> -
> -/* ----------------- LLC_CONN_STATE_AWAIT_REJ transitions --------------- */
> -/* State transitions for LLC_CONN_EV_DATA_CONN_REQ event */
> -static const llc_conn_ev_qfyr_t llc_await_reject_ev_qfyrs_1_0[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_refuse,
> -	[1] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_await_reject_actions_1_0[1];
> -
> -static const struct llc_conn_state_trans llc_await_reject_state_trans_1_0 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_await_reject_ev_qfyrs_1_0,
> -	.ev_actions    = llc_await_reject_actions_1_0,
> -};
> -
> -/* State transitions for LLC_CONN_EV_LOCAL_BUSY_DETECTED event */
> -static const llc_conn_action_t llc_await_rejct_actions_1[] = {
> -	[0] = llc_conn_ac_send_rnr_xxx_x_set_0,
> -	[1] = llc_conn_ac_set_data_flag_2,
> -	[2] = NULL
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_1 = {
> -	.ev	       = llc_conn_ev_local_busy_detected,
> -	.next_state    = LLC_CONN_STATE_AWAIT_BUSY,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_rejct_actions_2a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = NULL
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_2a = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_2a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_rejct_actions_2b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = NULL
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_2b = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_2b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_rejct_actions_3[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = NULL
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_3 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_4[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_stop_rej_timer,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_upd_vs,
> -	[6] = llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr,
> -	[7] = llc_conn_ac_clear_remote_busy,
> -	[8] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_5a[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[3] = llc_conn_ac_stop_rej_timer,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_upd_vs,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_5a = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_5a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_5b[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rr_xxx_x_set_0,
> -	[3] = llc_conn_ac_stop_rej_timer,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_upd_vs,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_5b = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_5b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_6[] = {
> -	[0] = llc_conn_ac_inc_vr_by_1,
> -	[1] = llc_conn_ac_data_ind,
> -	[2] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[3] = llc_conn_ac_stop_rej_timer,
> -	[4] = llc_conn_ac_upd_nr_received,
> -	[5] = llc_conn_ac_upd_vs,
> -	[6] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_6 = {
> -	.ev	       = llc_conn_ev_rx_i_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_7a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_7a = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_7a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_7b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_7b = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_7b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_I_RSP_Fbit_SET_1_UNEXPD_Ns event */
> -static const llc_conn_action_t llc_await_rejct_actions_7c[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_resend_i_xxx_x_set_0,
> -	[4] = llc_conn_ac_clear_remote_busy,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_7c = {
> -	.ev	       = llc_conn_ev_rx_i_rsp_fbit_set_1_unexpd_ns,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_7c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_8a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_8a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_8a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_8b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_8b = {
> -	.ev	       = llc_conn_ev_rx_rr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_8b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_8c[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_8c = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_8c,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_8d[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_clear_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_8d = {
> -	.ev	       = llc_conn_ev_rx_rej_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_8d,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_9a[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_9a = {
> -	.ev	       = llc_conn_ev_rx_rr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_9a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_REJ_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_9b[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_clear_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_9b = {
> -	.ev	       = llc_conn_ev_rx_rej_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_9b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_10[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_stop_p_timer,
> -	[3] = llc_conn_ac_set_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_10 = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_1,
> -	.next_state    = LLC_CONN_STATE_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_10,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_11a[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_11a = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_11a,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_RSP_Fbit_SET_0 event */
> -static const llc_conn_action_t llc_await_rejct_actions_11b[] = {
> -	[0] = llc_conn_ac_upd_nr_received,
> -	[1] = llc_conn_ac_upd_vs,
> -	[2] = llc_conn_ac_set_remote_busy,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_11b = {
> -	.ev	       = llc_conn_ev_rx_rnr_rsp_fbit_set_0,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_11b,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_RNR_CMD_Pbit_SET_1 event */
> -static const llc_conn_action_t llc_await_rejct_actions_12[] = {
> -	[0] = llc_conn_ac_send_rr_rsp_f_set_1,
> -	[1] = llc_conn_ac_upd_nr_received,
> -	[2] = llc_conn_ac_upd_vs,
> -	[3] = llc_conn_ac_set_remote_busy,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_12 = {
> -	.ev	       = llc_conn_ev_rx_rnr_cmd_pbit_set_1,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_await_rejct_actions_12,
> -};
> -
> -/* State transitions for LLC_CONN_EV_P_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_await_rejct_ev_qfyrs_13[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_await_rejct_actions_13[] = {
> -	[0] = llc_conn_ac_send_rej_cmd_p_set_1,
> -	[1] = llc_conn_ac_stop_p_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_await_rejct_state_trans_13 = {
> -	.ev	       = llc_conn_ev_p_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_AWAIT_REJ,
> -	.ev_qualifiers = llc_await_rejct_ev_qfyrs_13,
> -	.ev_actions    = llc_await_rejct_actions_13,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_await_rejct_state_transitions[] = {
> -	 [0] = &llc_await_reject_state_trans_1_0,
> -	 [1] = &llc_common_state_trans_1,		/* requests */
> -	 [2] = &llc_common_state_trans_2,
> -	 [3] = &llc_common_state_trans_end,
> -	 [4] = &llc_await_rejct_state_trans_1,		/* local busy */
> -	 [5] = &llc_common_state_trans_end,
> -	 [6] = &llc_common_state_trans_end,		/* Initiate PF cycle */
> -	 [7] = &llc_await_rejct_state_trans_13,	/* timers */
> -	 [8] = &llc_common_state_trans_11a,
> -	 [9] = &llc_common_state_trans_11b,
> -	[10] = &llc_common_state_trans_11c,
> -	[11] = &llc_common_state_trans_11d,
> -	[12] = &llc_common_state_trans_end,
> -	[13] = &llc_await_rejct_state_trans_2a,	/* receive frames */
> -	[14] = &llc_await_rejct_state_trans_2b,
> -	[15] = &llc_await_rejct_state_trans_3,
> -	[16] = &llc_await_rejct_state_trans_4,
> -	[17] = &llc_await_rejct_state_trans_5a,
> -	[18] = &llc_await_rejct_state_trans_5b,
> -	[19] = &llc_await_rejct_state_trans_6,
> -	[20] = &llc_await_rejct_state_trans_7a,
> -	[21] = &llc_await_rejct_state_trans_7b,
> -	[22] = &llc_await_rejct_state_trans_7c,
> -	[23] = &llc_await_rejct_state_trans_8a,
> -	[24] = &llc_await_rejct_state_trans_8b,
> -	[25] = &llc_await_rejct_state_trans_8c,
> -	[26] = &llc_await_rejct_state_trans_8d,
> -	[27] = &llc_await_rejct_state_trans_9a,
> -	[28] = &llc_await_rejct_state_trans_9b,
> -	[29] = &llc_await_rejct_state_trans_10,
> -	[30] = &llc_await_rejct_state_trans_11a,
> -	[31] = &llc_await_rejct_state_trans_11b,
> -	[32] = &llc_await_rejct_state_trans_12,
> -	[33] = &llc_common_state_trans_3,
> -	[34] = &llc_common_state_trans_4,
> -	[35] = &llc_common_state_trans_5,
> -	[36] = &llc_common_state_trans_6,
> -	[37] = &llc_common_state_trans_7a,
> -	[38] = &llc_common_state_trans_7b,
> -	[39] = &llc_common_state_trans_8a,
> -	[40] = &llc_common_state_trans_8b,
> -	[41] = &llc_common_state_trans_8c,
> -	[42] = &llc_common_state_trans_9,
> -	/* [43] = &llc_common_state_trans_10, */
> -	[43] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_D_CONN transitions */
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event,
> - * cause_flag = 1 */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_1[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_conflict,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_1[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
> -	[1] = llc_conn_ac_stop_ack_timer,
> -	[2] = llc_conn_ac_disc_confirm,
> -	[3] = llc_conn_disc,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_1 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_1,
> -	.ev_actions    = llc_d_conn_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event,
> - * cause_flag = 0
> - */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_1_1[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_set_status_conflict,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_1_1[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
> -	[1] = llc_conn_ac_stop_ack_timer,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_1_1 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_1_1,
> -	.ev_actions    = llc_d_conn_actions_1_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X event,
> - * cause_flag = 1
> - */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[2] = llc_conn_ev_qlfy_set_status_disc,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_2[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_ac_disc_confirm,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_2,
> -	.ev_actions    = llc_d_conn_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X event,
> - * cause_flag = 0
> - */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_2_1[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_set_status_disc,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_2_1[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_2_1 = {
> -	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_2_1,
> -	.ev_actions    = llc_d_conn_actions_2_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_d_conn_actions_3[] = {
> -	[0] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_3 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_D_CONN,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_d_conn_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event,
> - * cause_flag = 1
> - */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_4[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_disc,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_4[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_ac_disc_confirm,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_4,
> -	.ev_actions    = llc_d_conn_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event,
> - * cause_flag = 0
> - */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_4_1[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_set_status_disc,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_4_1[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_4_1 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_4_1,
> -	.ev_actions    = llc_d_conn_actions_4_1,
> -};
> -
> -/*
> - * State transition for
> - * LLC_CONN_EV_DATA_CONN_REQ event
> - */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_5[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_refuse,
> -	[1] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_d_conn_actions_5[1];
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_5 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_D_CONN,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_5,
> -	.ev_actions    = llc_d_conn_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_6[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_6[] = {
> -	[0] = llc_conn_ac_send_disc_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_6 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_D_CONN,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_6,
> -	.ev_actions    = llc_d_conn_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event, cause_flag = 1 */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_7[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[2] = llc_conn_ev_qlfy_set_status_failed,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_7[] = {
> -	[0] = llc_conn_ac_disc_confirm,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_7 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_7,
> -	.ev_actions    = llc_d_conn_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event, cause_flag = 0 */
> -static const llc_conn_ev_qfyr_t llc_d_conn_ev_qfyrs_8[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_set_status_failed,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_d_conn_actions_8[] = {
> -	[0] = llc_conn_disc,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_d_conn_state_trans_8 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_d_conn_ev_qfyrs_8,
> -	.ev_actions    = llc_d_conn_actions_8,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_d_conn_state_transitions[] = {
> -	 [0] = &llc_d_conn_state_trans_5,	/* Request */
> -	 [1] = &llc_common_state_trans_end,
> -	 [2] = &llc_common_state_trans_end,	/* Local busy */
> -	 [3] = &llc_common_state_trans_end,	/* Initiate PF cycle */
> -	 [4] = &llc_d_conn_state_trans_6,	/* Timer */
> -	 [5] = &llc_d_conn_state_trans_7,
> -	 [6] = &llc_d_conn_state_trans_8,
> -	 [7] = &llc_common_state_trans_end,
> -	 [8] = &llc_d_conn_state_trans_1,	/* Receive frame */
> -	 [9] = &llc_d_conn_state_trans_1_1,
> -	[10] = &llc_d_conn_state_trans_2,
> -	[11] = &llc_d_conn_state_trans_2_1,
> -	[12] = &llc_d_conn_state_trans_3,
> -	[13] = &llc_d_conn_state_trans_4,
> -	[14] = &llc_d_conn_state_trans_4_1,
> -	[15] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_RESET transitions */
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_rst_actions_1[] = {
> -	[0] = llc_conn_ac_set_vs_0,
> -	[1] = llc_conn_ac_set_vr_0,
> -	[2] = llc_conn_ac_set_s_flag_1,
> -	[3] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_1 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_rst_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X event,
> - * cause_flag = 1
> - */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_2[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[2] = llc_conn_ev_qlfy_set_status_conn,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_2[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_ac_set_vs_0,
> -	[2] = llc_conn_ac_set_vr_0,
> -	[3] = llc_conn_ac_upd_p_flag,
> -	[4] = llc_conn_ac_rst_confirm,
> -	[5] = llc_conn_ac_set_remote_busy_0,
> -	[6] = llc_conn_reset,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_2,
> -	.ev_actions    = llc_rst_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_UA_RSP_Fbit_SET_X event,
> - * cause_flag = 0
> - */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_2_1[] = {
> -	[0] = llc_conn_ev_qlfy_p_flag_eq_f,
> -	[1] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_set_status_rst_done,
> -	[3] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_2_1[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_ac_set_vs_0,
> -	[2] = llc_conn_ac_set_vr_0,
> -	[3] = llc_conn_ac_upd_p_flag,
> -	[4] = llc_conn_ac_rst_confirm,
> -	[5] = llc_conn_ac_set_remote_busy_0,
> -	[6] = llc_conn_reset,
> -	[7] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_2_1 = {
> -	.ev	       = llc_conn_ev_rx_ua_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_2_1,
> -	.ev_actions    = llc_rst_actions_2_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_3[] = {
> -	[0] = llc_conn_ev_qlfy_s_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_rst_done,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_3[] = {
> -	[0] = llc_conn_ac_set_p_flag_0,
> -	[1] = llc_conn_ac_set_remote_busy_0,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_3 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_3,
> -	.ev_actions    = llc_rst_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event,
> - * cause_flag = 1
> - */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_4[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_disc,
> -	[2] = NULL,
> -};
> -static const llc_conn_action_t llc_rst_actions_4[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
> -	[1] = llc_conn_ac_disc_ind,
> -	[2] = llc_conn_ac_stop_ack_timer,
> -	[3] = llc_conn_disc,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_4,
> -	.ev_actions    = llc_rst_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event,
> - * cause_flag = 0
> - */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_4_1[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_set_status_refuse,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_4_1[] = {
> -	[0] = llc_conn_ac_send_dm_rsp_f_set_p,
> -	[1] = llc_conn_ac_stop_ack_timer,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_4_1 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_4_1,
> -	.ev_actions    = llc_rst_actions_4_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event,
> - * cause_flag = 1
> - */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_5[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[1] = llc_conn_ev_qlfy_set_status_disc,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_5[] = {
> -	[0] = llc_conn_ac_disc_ind,
> -	[1] = llc_conn_ac_stop_ack_timer,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_5 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_5,
> -	.ev_actions    = llc_rst_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event,
> - * cause_flag = 0
> - */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_5_1[] = {
> -	[0] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[1] = llc_conn_ev_qlfy_set_status_refuse,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_5_1[] = {
> -	[0] = llc_conn_ac_stop_ack_timer,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_5_1 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_5_1,
> -	.ev_actions    = llc_rst_actions_5_1,
> -};
> -
> -/* State transitions for DATA_CONN_REQ event */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_6[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_refuse,
> -	[1] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_rst_actions_6[1];
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_6 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_6,
> -	.ev_actions    = llc_rst_actions_6,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_7[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = llc_conn_ev_qlfy_s_flag_eq_0,
> -	[2] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_rst_actions_7[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_7 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_7,
> -	.ev_actions    = llc_rst_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_8[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = llc_conn_ev_qlfy_s_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_cause_flag_eq_1,
> -	[3] = llc_conn_ev_qlfy_set_status_failed,
> -	[4] = NULL,
> -};
> -static const llc_conn_action_t llc_rst_actions_8[] = {
> -	[0] = llc_conn_ac_disc_ind,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_8 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_8,
> -	.ev_actions    = llc_rst_actions_8,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_rst_ev_qfyrs_8_1[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = llc_conn_ev_qlfy_s_flag_eq_0,
> -	[2] = llc_conn_ev_qlfy_cause_flag_eq_0,
> -	[3] = llc_conn_ev_qlfy_set_status_failed,
> -	[4] = NULL,
> -};
> -static const llc_conn_action_t llc_rst_actions_8_1[] = {
> -	[0] = llc_conn_ac_disc_ind,
> -	[1] = llc_conn_disc,
> -	[2] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_rst_state_trans_8_1 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = llc_rst_ev_qfyrs_8_1,
> -	.ev_actions    = llc_rst_actions_8_1,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_rst_state_transitions[] = {
> -	 [0] = &llc_rst_state_trans_6,		/* Request */
> -	 [1] = &llc_common_state_trans_end,
> -	 [2] = &llc_common_state_trans_end,	/* Local busy */
> -	 [3] = &llc_common_state_trans_end,	/* Initiate PF cycle */
> -	 [4] = &llc_rst_state_trans_3,		/* Timer */
> -	 [5] = &llc_rst_state_trans_7,
> -	 [6] = &llc_rst_state_trans_8,
> -	 [7] = &llc_rst_state_trans_8_1,
> -	 [8] = &llc_common_state_trans_end,
> -	 [9] = &llc_rst_state_trans_1,		/* Receive frame */
> -	[10] = &llc_rst_state_trans_2,
> -	[11] = &llc_rst_state_trans_2_1,
> -	[12] = &llc_rst_state_trans_4,
> -	[13] = &llc_rst_state_trans_4_1,
> -	[14] = &llc_rst_state_trans_5,
> -	[15] = &llc_rst_state_trans_5_1,
> -	[16] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_ERROR transitions */
> -/* State transitions for LLC_CONN_EV_RX_SABME_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_error_actions_1[] = {
> -	[0] = llc_conn_ac_set_vs_0,
> -	[1] = llc_conn_ac_set_vr_0,
> -	[2] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[3] = llc_conn_ac_rst_ind,
> -	[4] = llc_conn_ac_set_p_flag_0,
> -	[5] = llc_conn_ac_set_remote_busy_0,
> -	[6] = llc_conn_ac_stop_ack_timer,
> -	[7] = llc_conn_reset,
> -	[8] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_1 = {
> -	.ev	       = llc_conn_ev_rx_sabme_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_NORMAL,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_error_actions_1,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DISC_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_error_actions_2[] = {
> -	[0] = llc_conn_ac_send_ua_rsp_f_set_p,
> -	[1] = llc_conn_ac_disc_ind,
> -	[2] = llc_conn_ac_stop_ack_timer,
> -	[3] = llc_conn_disc,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_2 = {
> -	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_error_actions_2,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_DM_RSP_Fbit_SET_X event */
> -static const llc_conn_action_t llc_error_actions_3[] = {
> -	[0] = llc_conn_ac_disc_ind,
> -	[1] = llc_conn_ac_stop_ack_timer,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_3 = {
> -	.ev	       = llc_conn_ev_rx_dm_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_error_actions_3,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_FRMR_RSP_Fbit_SET_X event */
> -static const llc_conn_action_t llc_error_actions_4[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_set_retry_cnt_0,
> -	[3] = llc_conn_ac_set_cause_flag_0,
> -	[4] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_4 = {
> -	.ev	       = llc_conn_ev_rx_frmr_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_error_actions_4,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_XXX_CMD_Pbit_SET_X event */
> -static const llc_conn_action_t llc_error_actions_5[] = {
> -	[0] = llc_conn_ac_resend_frmr_rsp_f_set_p,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_5 = {
> -	.ev	       = llc_conn_ev_rx_xxx_cmd_pbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_error_actions_5,
> -};
> -
> -/* State transitions for LLC_CONN_EV_RX_XXX_RSP_Fbit_SET_X event */
> -static const struct llc_conn_state_trans llc_error_state_trans_6 = {
> -	.ev	       = llc_conn_ev_rx_xxx_rsp_fbit_set_x,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = NONE,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_error_ev_qfyrs_7[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_lt_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_error_actions_7[] = {
> -	[0] = llc_conn_ac_resend_frmr_rsp_f_set_0,
> -	[1] = llc_conn_ac_start_ack_timer,
> -	[2] = llc_conn_ac_inc_retry_cnt_by_1,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_7 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = llc_error_ev_qfyrs_7,
> -	.ev_actions    = llc_error_actions_7,
> -};
> -
> -/* State transitions for LLC_CONN_EV_ACK_TMR_EXP event */
> -static const llc_conn_ev_qfyr_t llc_error_ev_qfyrs_8[] = {
> -	[0] = llc_conn_ev_qlfy_retry_cnt_gte_n2,
> -	[1] = NULL,
> -};
> -
> -static const llc_conn_action_t llc_error_actions_8[] = {
> -	[0] = llc_conn_ac_send_sabme_cmd_p_set_x,
> -	[1] = llc_conn_ac_set_s_flag_0,
> -	[2] = llc_conn_ac_start_ack_timer,
> -	[3] = llc_conn_ac_set_retry_cnt_0,
> -	[4] = llc_conn_ac_set_cause_flag_0,
> -	[5] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_8 = {
> -	.ev	       = llc_conn_ev_ack_tmr_exp,
> -	.next_state    = LLC_CONN_STATE_RESET,
> -	.ev_qualifiers = llc_error_ev_qfyrs_8,
> -	.ev_actions    = llc_error_actions_8,
> -};
> -
> -/* State transitions for LLC_CONN_EV_DATA_CONN_REQ event */
> -static const llc_conn_ev_qfyr_t llc_error_ev_qfyrs_9[] = {
> -	[0] = llc_conn_ev_qlfy_set_status_refuse,
> -	[1] = NULL,
> -};
> -
> -/* just one member, NULL, .bss zeroes it */
> -static const llc_conn_action_t llc_error_actions_9[1];
> -
> -static const struct llc_conn_state_trans llc_error_state_trans_9 = {
> -	.ev	       = llc_conn_ev_data_req,
> -	.next_state    = LLC_CONN_STATE_ERROR,
> -	.ev_qualifiers = llc_error_ev_qfyrs_9,
> -	.ev_actions    = llc_error_actions_9,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_error_state_transitions[] = {
> -	 [0] = &llc_error_state_trans_9,	/* Request */
> -	 [1] = &llc_common_state_trans_end,
> -	 [2] = &llc_common_state_trans_end,	/* Local busy */
> -	 [3] = &llc_common_state_trans_end,	/* Initiate PF cycle */
> -	 [4] = &llc_error_state_trans_7,	/* Timer */
> -	 [5] = &llc_error_state_trans_8,
> -	 [6] = &llc_common_state_trans_end,
> -	 [7] = &llc_error_state_trans_1,	/* Receive frame */
> -	 [8] = &llc_error_state_trans_2,
> -	 [9] = &llc_error_state_trans_3,
> -	[10] = &llc_error_state_trans_4,
> -	[11] = &llc_error_state_trans_5,
> -	[12] = &llc_error_state_trans_6,
> -	[13] = &llc_common_state_trans_end,
> -};
> -
> -/* LLC_CONN_STATE_TEMP transitions */
> -/* State transitions for LLC_CONN_EV_DISC_REQ event */
> -static const llc_conn_action_t llc_temp_actions_1[] = {
> -	[0] = llc_conn_ac_stop_all_timers,
> -	[1] = llc_conn_ac_send_disc_cmd_p_set_x,
> -	[2] = llc_conn_disc,
> -	[3] = NULL,
> -};
> -
> -static const struct llc_conn_state_trans llc_temp_state_trans_1 = {
> -	.ev	       = llc_conn_ev_disc_req,
> -	.next_state    = LLC_CONN_STATE_ADM,
> -	.ev_qualifiers = NONE,
> -	.ev_actions    = llc_temp_actions_1,
> -};
> -
> -/*
> - * Array of pointers;
> - * one to each transition
> - */
> -static const struct llc_conn_state_trans *llc_temp_state_transitions[] = {
> -	[0] = &llc_temp_state_trans_1,		/* requests */
> -	[1] = &llc_common_state_trans_end,
> -	[2] = &llc_common_state_trans_end,	/* local busy */
> -	[3] = &llc_common_state_trans_end,	/* init_pf_cycle */
> -	[4] = &llc_common_state_trans_end,	/* timer */
> -	[5] = &llc_common_state_trans_end,	/* receive */
> -};
> -
> -/* Connection State Transition Table */
> -struct llc_conn_state llc_conn_state_table[NBR_CONN_STATES] = {
> -	[LLC_CONN_STATE_ADM - 1] = {
> -		.current_state	= LLC_CONN_STATE_ADM,
> -		.transitions	= llc_adm_state_transitions,
> -	},
> -	[LLC_CONN_STATE_SETUP - 1] = {
> -		.current_state	= LLC_CONN_STATE_SETUP,
> -		.transitions	= llc_setup_state_transitions,
> -	},
> -	[LLC_CONN_STATE_NORMAL - 1] = {
> -		.current_state	= LLC_CONN_STATE_NORMAL,
> -		.transitions	= llc_normal_state_transitions,
> -	},
> -	[LLC_CONN_STATE_BUSY - 1] = {
> -		.current_state	= LLC_CONN_STATE_BUSY,
> -		.transitions	= llc_busy_state_transitions,
> -	},
> -	[LLC_CONN_STATE_REJ - 1] = {
> -		.current_state	= LLC_CONN_STATE_REJ,
> -		.transitions	= llc_reject_state_transitions,
> -	},
> -	[LLC_CONN_STATE_AWAIT - 1] = {
> -		.current_state	= LLC_CONN_STATE_AWAIT,
> -		.transitions	= llc_await_state_transitions,
> -	},
> -	[LLC_CONN_STATE_AWAIT_BUSY - 1] = {
> -		.current_state	= LLC_CONN_STATE_AWAIT_BUSY,
> -		.transitions	= llc_await_busy_state_transitions,
> -	},
> -	[LLC_CONN_STATE_AWAIT_REJ - 1] = {
> -		.current_state	= LLC_CONN_STATE_AWAIT_REJ,
> -		.transitions	= llc_await_rejct_state_transitions,
> -	},
> -	[LLC_CONN_STATE_D_CONN - 1] = {
> -		.current_state	= LLC_CONN_STATE_D_CONN,
> -		.transitions	= llc_d_conn_state_transitions,
> -	},
> -	[LLC_CONN_STATE_RESET - 1] = {
> -		.current_state	= LLC_CONN_STATE_RESET,
> -		.transitions	= llc_rst_state_transitions,
> -	},
> -	[LLC_CONN_STATE_ERROR - 1] = {
> -		.current_state	= LLC_CONN_STATE_ERROR,
> -		.transitions	= llc_error_state_transitions,
> -	},
> -	[LLC_CONN_STATE_TEMP - 1] = {
> -		.current_state	= LLC_CONN_STATE_TEMP,
> -		.transitions	= llc_temp_state_transitions,
> -	},
> -};
> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> deleted file mode 100644
> index 4b6fe9a473cb..000000000000
> --- a/net/llc/llc_conn.c
> +++ /dev/null
> @@ -1,1025 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_conn.c - Driver routines for connection component.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <net/llc.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_c_st.h>
> -#include <net/llc_conn.h>
> -#include <net/llc_pdu.h>
> -#include <net/llc_sap.h>
> -#include <net/sock.h>
> -#include <net/tcp_states.h>
> -
> -#if 0
> -#define dprintk(args...) printk(KERN_DEBUG args)
> -#else
> -#define dprintk(args...)
> -#endif
> -
> -static int llc_find_offset(int state, int ev_type);
> -static void llc_conn_send_pdus(struct sock *sk);
> -static int llc_conn_service(struct sock *sk, struct sk_buff *skb);
> -static int llc_exec_conn_trans_actions(struct sock *sk,
> -				       const struct llc_conn_state_trans *trans,
> -				       struct sk_buff *ev);
> -static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
> -							      struct sk_buff *skb);
> -
> -/* Offset table on connection states transition diagram */
> -static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
> -
> -int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
> -int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
> -int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
> -int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
> -
> -/**
> - *	llc_conn_state_process - sends event to connection state machine
> - *	@sk: connection
> - *	@skb: occurred event
> - *
> - *	Sends an event to connection state machine. After processing event
> - *	(executing it's actions and changing state), upper layer will be
> - *	indicated or confirmed, if needed. Returns 0 for success, 1 for
> - *	failure. The socket lock has to be held before calling this function.
> - *
> - *	This function always consumes a reference to the skb.
> - */
> -int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc;
> -	struct llc_sock *llc = llc_sk(skb->sk);
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->ind_prim = ev->cfm_prim = 0;
> -	/*
> -	 * Send event to state machine
> -	 */
> -	rc = llc_conn_service(skb->sk, skb);
> -	if (unlikely(rc != 0)) {
> -		printk(KERN_ERR "%s: llc_conn_service failed\n", __func__);
> -		goto out_skb_put;
> -	}
> -
> -	switch (ev->ind_prim) {
> -	case LLC_DATA_PRIM:
> -		skb_get(skb);
> -		llc_save_primitive(sk, skb, LLC_DATA_PRIM);
> -		if (unlikely(sock_queue_rcv_skb(sk, skb))) {
> -			/*
> -			 * shouldn't happen
> -			 */
> -			printk(KERN_ERR "%s: sock_queue_rcv_skb failed!\n",
> -			       __func__);
> -			kfree_skb(skb);
> -		}
> -		break;
> -	case LLC_CONN_PRIM:
> -		/*
> -		 * Can't be sock_queue_rcv_skb, because we have to leave the
> -		 * skb->sk pointing to the newly created struct sock in
> -		 * llc_conn_handler. -acme
> -		 */
> -		skb_get(skb);
> -		skb_queue_tail(&sk->sk_receive_queue, skb);
> -		sk->sk_state_change(sk);
> -		break;
> -	case LLC_DISC_PRIM:
> -		sock_hold(sk);
> -		if (sk->sk_type == SOCK_STREAM &&
> -		    sk->sk_state == TCP_ESTABLISHED) {
> -			sk->sk_shutdown       = SHUTDOWN_MASK;
> -			sk->sk_socket->state  = SS_UNCONNECTED;
> -			sk->sk_state          = TCP_CLOSE;
> -			if (!sock_flag(sk, SOCK_DEAD)) {
> -				sock_set_flag(sk, SOCK_DEAD);
> -				sk->sk_state_change(sk);
> -			}
> -		}
> -		sock_put(sk);
> -		break;
> -	case LLC_RESET_PRIM:
> -		/*
> -		 * FIXME:
> -		 * RESET is not being notified to upper layers for now
> -		 */
> -		printk(KERN_INFO "%s: received a reset ind!\n", __func__);
> -		break;
> -	default:
> -		if (ev->ind_prim)
> -			printk(KERN_INFO "%s: received unknown %d prim!\n",
> -				__func__, ev->ind_prim);
> -		/* No indication */
> -		break;
> -	}
> -
> -	switch (ev->cfm_prim) {
> -	case LLC_DATA_PRIM:
> -		if (!llc_data_accept_state(llc->state))
> -			sk->sk_write_space(sk);
> -		else
> -			rc = llc->failed_data_req = 1;
> -		break;
> -	case LLC_CONN_PRIM:
> -		if (sk->sk_type == SOCK_STREAM &&
> -		    sk->sk_state == TCP_SYN_SENT) {
> -			if (ev->status) {
> -				sk->sk_socket->state = SS_UNCONNECTED;
> -				sk->sk_state         = TCP_CLOSE;
> -			} else {
> -				sk->sk_socket->state = SS_CONNECTED;
> -				sk->sk_state         = TCP_ESTABLISHED;
> -			}
> -			sk->sk_state_change(sk);
> -		}
> -		break;
> -	case LLC_DISC_PRIM:
> -		sock_hold(sk);
> -		if (sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_CLOSING) {
> -			sk->sk_socket->state = SS_UNCONNECTED;
> -			sk->sk_state         = TCP_CLOSE;
> -			sk->sk_state_change(sk);
> -		}
> -		sock_put(sk);
> -		break;
> -	case LLC_RESET_PRIM:
> -		/*
> -		 * FIXME:
> -		 * RESET is not being notified to upper layers for now
> -		 */
> -		printk(KERN_INFO "%s: received a reset conf!\n", __func__);
> -		break;
> -	default:
> -		if (ev->cfm_prim)
> -			printk(KERN_INFO "%s: received unknown %d prim!\n",
> -					__func__, ev->cfm_prim);
> -		/* No confirmation */
> -		break;
> -	}
> -out_skb_put:
> -	kfree_skb(skb);
> -	return rc;
> -}
> -
> -void llc_conn_send_pdu(struct sock *sk, struct sk_buff *skb)
> -{
> -	/* queue PDU to send to MAC layer */
> -	skb_queue_tail(&sk->sk_write_queue, skb);
> -	llc_conn_send_pdus(sk);
> -}
> -
> -/**
> - *	llc_conn_rtn_pdu - sends received data pdu to upper layer
> - *	@sk: Active connection
> - *	@skb: Received data frame
> - *
> - *	Sends received data pdu to upper layer (by using indicate function).
> - *	Prepares service parameters (prim and prim_data). calling indication
> - *	function will be done in llc_conn_state_process.
> - */
> -void llc_conn_rtn_pdu(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->ind_prim = LLC_DATA_PRIM;
> -}
> -
> -/**
> - *	llc_conn_resend_i_pdu_as_cmd - resend all unacknowledged I PDUs
> - *	@sk: active connection
> - *	@nr: NR
> - *	@first_p_bit: p_bit value of first pdu
> - *
> - *	Resend all unacknowledged I PDUs, starting with the NR; send first as
> - *	command PDU with P bit equal first_p_bit; if more than one send
> - *	subsequent as command PDUs with P bit equal zero (0).
> - */
> -void llc_conn_resend_i_pdu_as_cmd(struct sock *sk, u8 nr, u8 first_p_bit)
> -{
> -	struct sk_buff *skb;
> -	struct llc_pdu_sn *pdu;
> -	u16 nbr_unack_pdus;
> -	struct llc_sock *llc;
> -	u8 howmany_resend = 0;
> -
> -	llc_conn_remove_acked_pdus(sk, nr, &nbr_unack_pdus);
> -	if (!nbr_unack_pdus)
> -		goto out;
> -	/*
> -	 * Process unack PDUs only if unack queue is not empty; remove
> -	 * appropriate PDUs, fix them up, and put them on mac_pdu_q.
> -	 */
> -	llc = llc_sk(sk);
> -
> -	while ((skb = skb_dequeue(&llc->pdu_unack_q)) != NULL) {
> -		pdu = llc_pdu_sn_hdr(skb);
> -		llc_pdu_set_cmd_rsp(skb, LLC_PDU_CMD);
> -		llc_pdu_set_pf_bit(skb, first_p_bit);
> -		skb_queue_tail(&sk->sk_write_queue, skb);
> -		first_p_bit = 0;
> -		llc->vS = LLC_I_GET_NS(pdu);
> -		howmany_resend++;
> -	}
> -	if (howmany_resend > 0)
> -		llc->vS = (llc->vS + 1) % LLC_2_SEQ_NBR_MODULO;
> -	/* any PDUs to re-send are queued up; start sending to MAC */
> -	llc_conn_send_pdus(sk);
> -out:;
> -}
> -
> -/**
> - *	llc_conn_resend_i_pdu_as_rsp - Resend all unacknowledged I PDUs
> - *	@sk: active connection.
> - *	@nr: NR
> - *	@first_f_bit: f_bit value of first pdu.
> - *
> - *	Resend all unacknowledged I PDUs, starting with the NR; send first as
> - *	response PDU with F bit equal first_f_bit; if more than one send
> - *	subsequent as response PDUs with F bit equal zero (0).
> - */
> -void llc_conn_resend_i_pdu_as_rsp(struct sock *sk, u8 nr, u8 first_f_bit)
> -{
> -	struct sk_buff *skb;
> -	u16 nbr_unack_pdus;
> -	struct llc_sock *llc = llc_sk(sk);
> -	u8 howmany_resend = 0;
> -
> -	llc_conn_remove_acked_pdus(sk, nr, &nbr_unack_pdus);
> -	if (!nbr_unack_pdus)
> -		goto out;
> -	/*
> -	 * Process unack PDUs only if unack queue is not empty; remove
> -	 * appropriate PDUs, fix them up, and put them on mac_pdu_q
> -	 */
> -	while ((skb = skb_dequeue(&llc->pdu_unack_q)) != NULL) {
> -		struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -		llc_pdu_set_cmd_rsp(skb, LLC_PDU_RSP);
> -		llc_pdu_set_pf_bit(skb, first_f_bit);
> -		skb_queue_tail(&sk->sk_write_queue, skb);
> -		first_f_bit = 0;
> -		llc->vS = LLC_I_GET_NS(pdu);
> -		howmany_resend++;
> -	}
> -	if (howmany_resend > 0)
> -		llc->vS = (llc->vS + 1) % LLC_2_SEQ_NBR_MODULO;
> -	/* any PDUs to re-send are queued up; start sending to MAC */
> -	llc_conn_send_pdus(sk);
> -out:;
> -}
> -
> -/**
> - *	llc_conn_remove_acked_pdus - Removes acknowledged pdus from tx queue
> - *	@sk: active connection
> - *	@nr: NR
> - *	@how_many_unacked: size of pdu_unack_q after removing acked pdus
> - *
> - *	Removes acknowledged pdus from transmit queue (pdu_unack_q). Returns
> - *	the number of pdus that removed from queue.
> - */
> -int llc_conn_remove_acked_pdus(struct sock *sk, u8 nr, u16 *how_many_unacked)
> -{
> -	int pdu_pos, i;
> -	struct sk_buff *skb;
> -	struct llc_pdu_sn *pdu;
> -	int nbr_acked = 0;
> -	struct llc_sock *llc = llc_sk(sk);
> -	int q_len = skb_queue_len(&llc->pdu_unack_q);
> -
> -	if (!q_len)
> -		goto out;
> -	skb = skb_peek(&llc->pdu_unack_q);
> -	pdu = llc_pdu_sn_hdr(skb);
> -
> -	/* finding position of last acked pdu in queue */
> -	pdu_pos = ((int)LLC_2_SEQ_NBR_MODULO + (int)nr -
> -			(int)LLC_I_GET_NS(pdu)) % LLC_2_SEQ_NBR_MODULO;
> -
> -	for (i = 0; i < pdu_pos && i < q_len; i++) {
> -		skb = skb_dequeue(&llc->pdu_unack_q);
> -		kfree_skb(skb);
> -		nbr_acked++;
> -	}
> -out:
> -	*how_many_unacked = skb_queue_len(&llc->pdu_unack_q);
> -	return nbr_acked;
> -}
> -
> -/**
> - *	llc_conn_send_pdus - Sends queued PDUs
> - *	@sk: active connection
> - *
> - *	Sends queued pdus to MAC layer for transmission.
> - */
> -static void llc_conn_send_pdus(struct sock *sk)
> -{
> -	struct sk_buff *skb;
> -
> -	while ((skb = skb_dequeue(&sk->sk_write_queue)) != NULL) {
> -		struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -		if (LLC_PDU_TYPE_IS_I(pdu) &&
> -		    !(skb->dev->flags & IFF_LOOPBACK)) {
> -			struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
> -
> -			skb_queue_tail(&llc_sk(sk)->pdu_unack_q, skb);
> -			if (!skb2)
> -				break;
> -			skb = skb2;
> -		}
> -		dev_queue_xmit(skb);
> -	}
> -}
> -
> -/**
> - *	llc_conn_service - finds transition and changes state of connection
> - *	@sk: connection
> - *	@skb: happened event
> - *
> - *	This function finds transition that matches with happened event, then
> - *	executes related actions and finally changes state of connection.
> - *	Returns 0 for success, 1 for failure.
> - */
> -static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_trans *trans;
> -	struct llc_sock *llc = llc_sk(sk);
> -	int rc = 1;
> -
> -	if (llc->state > NBR_CONN_STATES)
> -		goto out;
> -	rc = 0;
> -	trans = llc_qualify_conn_ev(sk, skb);
> -	if (trans) {
> -		rc = llc_exec_conn_trans_actions(sk, trans, skb);
> -		if (!rc && trans->next_state != NO_STATE_CHANGE) {
> -			llc->state = trans->next_state;
> -			if (!llc_data_accept_state(llc->state))
> -				sk->sk_state_change(sk);
> -		}
> -	}
> -out:
> -	return rc;
> -}
> -
> -/**
> - *	llc_qualify_conn_ev - finds transition for event
> - *	@sk: connection
> - *	@skb: happened event
> - *
> - *	This function finds transition that matches with happened event.
> - *	Returns pointer to found transition on success, %NULL otherwise.
> - */
> -static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
> -							      struct sk_buff *skb)
> -{
> -	const struct llc_conn_state_trans **next_trans;
> -	const llc_conn_ev_qfyr_t *next_qualifier;
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct llc_conn_state *curr_state =
> -					&llc_conn_state_table[llc->state - 1];
> -
> -	/* search thru events for this state until
> -	 * list exhausted or until no more
> -	 */
> -	for (next_trans = curr_state->transitions +
> -		llc_find_offset(llc->state - 1, ev->type);
> -	     (*next_trans)->ev; next_trans++) {
> -		if (!((*next_trans)->ev)(sk, skb)) {
> -			/* got POSSIBLE event match; the event may require
> -			 * qualification based on the values of a number of
> -			 * state flags; if all qualifications are met (i.e.,
> -			 * if all qualifying functions return success, or 0,
> -			 * then this is THE event we're looking for
> -			 */
> -			for (next_qualifier = (*next_trans)->ev_qualifiers;
> -			     next_qualifier && *next_qualifier &&
> -			     !(*next_qualifier)(sk, skb); next_qualifier++)
> -				/* nothing */;
> -			if (!next_qualifier || !*next_qualifier)
> -				/* all qualifiers executed successfully; this is
> -				 * our transition; return it so we can perform
> -				 * the associated actions & change the state
> -				 */
> -				return *next_trans;
> -		}
> -	}
> -	return NULL;
> -}
> -
> -/**
> - *	llc_exec_conn_trans_actions - executes related actions
> - *	@sk: connection
> - *	@trans: transition that it's actions must be performed
> - *	@skb: event
> - *
> - *	Executes actions that is related to happened event. Returns 0 for
> - *	success, 1 to indicate failure of at least one action.
> - */
> -static int llc_exec_conn_trans_actions(struct sock *sk,
> -				       const struct llc_conn_state_trans *trans,
> -				       struct sk_buff *skb)
> -{
> -	int rc = 0;
> -	const llc_conn_action_t *next_action;
> -
> -	for (next_action = trans->ev_actions;
> -	     next_action && *next_action; next_action++) {
> -		int rc2 = (*next_action)(sk, skb);
> -
> -		if (rc2 == 2) {
> -			rc = rc2;
> -			break;
> -		} else if (rc2)
> -			rc = 1;
> -	}
> -	return rc;
> -}
> -
> -static inline bool llc_estab_match(const struct llc_sap *sap,
> -				   const struct llc_addr *daddr,
> -				   const struct llc_addr *laddr,
> -				   const struct sock *sk,
> -				   const struct net *net)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	return net_eq(sock_net(sk), net) &&
> -		llc->laddr.lsap == laddr->lsap &&
> -		llc->daddr.lsap == daddr->lsap &&
> -		ether_addr_equal(llc->laddr.mac, laddr->mac) &&
> -		ether_addr_equal(llc->daddr.mac, daddr->mac);
> -}
> -
> -/**
> - *	__llc_lookup_established - Finds connection for the remote/local sap/mac
> - *	@sap: SAP
> - *	@daddr: address of remote LLC (MAC + SAP)
> - *	@laddr: address of local LLC (MAC + SAP)
> - *	@net: netns to look up a socket in
> - *
> - *	Search connection list of the SAP and finds connection using the remote
> - *	mac, remote sap, local mac, and local sap. Returns pointer for
> - *	connection found, %NULL otherwise.
> - *	Caller has to make sure local_bh is disabled.
> - */
> -static struct sock *__llc_lookup_established(struct llc_sap *sap,
> -					     struct llc_addr *daddr,
> -					     struct llc_addr *laddr,
> -					     const struct net *net)
> -{
> -	struct sock *rc;
> -	struct hlist_nulls_node *node;
> -	int slot = llc_sk_laddr_hashfn(sap, laddr);
> -	struct hlist_nulls_head *laddr_hb = &sap->sk_laddr_hash[slot];
> -
> -	rcu_read_lock();
> -again:
> -	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
> -		if (llc_estab_match(sap, daddr, laddr, rc, net)) {
> -			/* Extra checks required by SLAB_TYPESAFE_BY_RCU */
> -			if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
> -				goto again;
> -			if (unlikely(llc_sk(rc)->sap != sap ||
> -				     !llc_estab_match(sap, daddr, laddr, rc, net))) {
> -				sock_put(rc);
> -				continue;
> -			}
> -			goto found;
> -		}
> -	}
> -	rc = NULL;
> -	/*
> -	 * if the nulls value we got at the end of this lookup is
> -	 * not the expected one, we must restart lookup.
> -	 * We probably met an item that was moved to another chain.
> -	 */
> -	if (unlikely(get_nulls_value(node) != slot))
> -		goto again;
> -found:
> -	rcu_read_unlock();
> -	return rc;
> -}
> -
> -struct sock *llc_lookup_established(struct llc_sap *sap,
> -				    struct llc_addr *daddr,
> -				    struct llc_addr *laddr,
> -				    const struct net *net)
> -{
> -	struct sock *sk;
> -
> -	local_bh_disable();
> -	sk = __llc_lookup_established(sap, daddr, laddr, net);
> -	local_bh_enable();
> -	return sk;
> -}
> -
> -static inline bool llc_listener_match(const struct llc_sap *sap,
> -				      const struct llc_addr *laddr,
> -				      const struct sock *sk,
> -				      const struct net *net)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	return net_eq(sock_net(sk), net) &&
> -		sk->sk_type == SOCK_STREAM && sk->sk_state == TCP_LISTEN &&
> -		llc->laddr.lsap == laddr->lsap &&
> -		ether_addr_equal(llc->laddr.mac, laddr->mac);
> -}
> -
> -static struct sock *__llc_lookup_listener(struct llc_sap *sap,
> -					  struct llc_addr *laddr,
> -					  const struct net *net)
> -{
> -	struct sock *rc;
> -	struct hlist_nulls_node *node;
> -	int slot = llc_sk_laddr_hashfn(sap, laddr);
> -	struct hlist_nulls_head *laddr_hb = &sap->sk_laddr_hash[slot];
> -
> -	rcu_read_lock();
> -again:
> -	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
> -		if (llc_listener_match(sap, laddr, rc, net)) {
> -			/* Extra checks required by SLAB_TYPESAFE_BY_RCU */
> -			if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
> -				goto again;
> -			if (unlikely(llc_sk(rc)->sap != sap ||
> -				     !llc_listener_match(sap, laddr, rc, net))) {
> -				sock_put(rc);
> -				continue;
> -			}
> -			goto found;
> -		}
> -	}
> -	rc = NULL;
> -	/*
> -	 * if the nulls value we got at the end of this lookup is
> -	 * not the expected one, we must restart lookup.
> -	 * We probably met an item that was moved to another chain.
> -	 */
> -	if (unlikely(get_nulls_value(node) != slot))
> -		goto again;
> -found:
> -	rcu_read_unlock();
> -	return rc;
> -}
> -
> -/**
> - *	llc_lookup_listener - Finds listener for local MAC + SAP
> - *	@sap: SAP
> - *	@laddr: address of local LLC (MAC + SAP)
> - *	@net: netns to look up a socket in
> - *
> - *	Search connection list of the SAP and finds connection listening on
> - *	local mac, and local sap. Returns pointer for parent socket found,
> - *	%NULL otherwise.
> - *	Caller has to make sure local_bh is disabled.
> - */
> -static struct sock *llc_lookup_listener(struct llc_sap *sap,
> -					struct llc_addr *laddr,
> -					const struct net *net)
> -{
> -	struct sock *rc = __llc_lookup_listener(sap, laddr, net);
> -	static struct llc_addr null_addr;
> -
> -	if (!rc)
> -		rc = __llc_lookup_listener(sap, &null_addr, net);
> -
> -	return rc;
> -}
> -
> -static struct sock *__llc_lookup(struct llc_sap *sap,
> -				 struct llc_addr *daddr,
> -				 struct llc_addr *laddr,
> -				 const struct net *net)
> -{
> -	struct sock *sk = __llc_lookup_established(sap, daddr, laddr, net);
> -
> -	return sk ? : llc_lookup_listener(sap, laddr, net);
> -}
> -
> -/**
> - *	llc_data_accept_state - designates if in this state data can be sent.
> - *	@state: state of connection.
> - *
> - *	Returns 0 if data can be sent, 1 otherwise.
> - */
> -u8 llc_data_accept_state(u8 state)
> -{
> -	return state != LLC_CONN_STATE_NORMAL && state != LLC_CONN_STATE_BUSY &&
> -	       state != LLC_CONN_STATE_REJ;
> -}
> -
> -/**
> - *	llc_find_next_offset - finds offset for next category of transitions
> - *	@state: state table.
> - *	@offset: start offset.
> - *
> - *	Finds offset of next category of transitions in transition table.
> - *	Returns the start index of next category.
> - */
> -static u16 __init llc_find_next_offset(struct llc_conn_state *state, u16 offset)
> -{
> -	const struct llc_conn_state_trans **next_trans;
> -	u16 cnt = 0;
> -
> -	for (next_trans = state->transitions + offset;
> -	     (*next_trans)->ev; next_trans++)
> -		++cnt;
> -	return cnt;
> -}
> -
> -/**
> - *	llc_build_offset_table - builds offset table of connection
> - *
> - *	Fills offset table of connection state transition table
> - *	(llc_offset_table).
> - */
> -void __init llc_build_offset_table(void)
> -{
> -	struct llc_conn_state *curr_state;
> -	int state, ev_type, next_offset;
> -
> -	for (state = 0; state < NBR_CONN_STATES; state++) {
> -		curr_state = &llc_conn_state_table[state];
> -		next_offset = 0;
> -		for (ev_type = 0; ev_type < NBR_CONN_EV; ev_type++) {
> -			llc_offset_table[state][ev_type] = next_offset;
> -			next_offset += llc_find_next_offset(curr_state,
> -							    next_offset) + 1;
> -		}
> -	}
> -}
> -
> -/**
> - *	llc_find_offset - finds start offset of category of transitions
> - *	@state: state of connection
> - *	@ev_type: type of happened event
> - *
> - *	Finds start offset of desired category of transitions. Returns the
> - *	desired start offset.
> - */
> -static int llc_find_offset(int state, int ev_type)
> -{
> -	int rc = 0;
> -	/* at this stage, llc_offset_table[..][2] is not important. it is for
> -	 * init_pf_cycle and I don't know what is it.
> -	 */
> -	switch (ev_type) {
> -	case LLC_CONN_EV_TYPE_PRIM:
> -		rc = llc_offset_table[state][0]; break;
> -	case LLC_CONN_EV_TYPE_PDU:
> -		rc = llc_offset_table[state][4]; break;
> -	case LLC_CONN_EV_TYPE_SIMPLE:
> -		rc = llc_offset_table[state][1]; break;
> -	case LLC_CONN_EV_TYPE_P_TMR:
> -	case LLC_CONN_EV_TYPE_ACK_TMR:
> -	case LLC_CONN_EV_TYPE_REJ_TMR:
> -	case LLC_CONN_EV_TYPE_BUSY_TMR:
> -		rc = llc_offset_table[state][3]; break;
> -	}
> -	return rc;
> -}
> -
> -/**
> - *	llc_sap_add_socket - adds a socket to a SAP
> - *	@sap: SAP
> - *	@sk: socket
> - *
> - *	This function adds a socket to the hash tables of a SAP.
> - */
> -void llc_sap_add_socket(struct llc_sap *sap, struct sock *sk)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct hlist_head *dev_hb = llc_sk_dev_hash(sap, llc->dev->ifindex);
> -	struct hlist_nulls_head *laddr_hb = llc_sk_laddr_hash(sap, &llc->laddr);
> -
> -	llc_sap_hold(sap);
> -	llc_sk(sk)->sap = sap;
> -
> -	spin_lock_bh(&sap->sk_lock);
> -	sock_set_flag(sk, SOCK_RCU_FREE);
> -	sap->sk_count++;
> -	sk_nulls_add_node_rcu(sk, laddr_hb);
> -	hlist_add_head(&llc->dev_hash_node, dev_hb);
> -	spin_unlock_bh(&sap->sk_lock);
> -}
> -
> -/**
> - *	llc_sap_remove_socket - removes a socket from SAP
> - *	@sap: SAP
> - *	@sk: socket
> - *
> - *	This function removes a connection from the hash tables of a SAP if
> - *	the connection was in this list.
> - */
> -void llc_sap_remove_socket(struct llc_sap *sap, struct sock *sk)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	spin_lock_bh(&sap->sk_lock);
> -	sk_nulls_del_node_init_rcu(sk);
> -	hlist_del(&llc->dev_hash_node);
> -	sap->sk_count--;
> -	spin_unlock_bh(&sap->sk_lock);
> -	llc_sap_put(sap);
> -}
> -
> -/**
> - *	llc_conn_rcv - sends received pdus to the connection state machine
> - *	@sk: current connection structure.
> - *	@skb: received frame.
> - *
> - *	Sends received pdus to the connection state machine.
> - */
> -static int llc_conn_rcv(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -	ev->type   = LLC_CONN_EV_TYPE_PDU;
> -	ev->reason = 0;
> -	return llc_conn_state_process(sk, skb);
> -}
> -
> -static struct sock *llc_create_incoming_sock(struct sock *sk,
> -					     struct net_device *dev,
> -					     struct llc_addr *saddr,
> -					     struct llc_addr *daddr)
> -{
> -	struct sock *newsk = llc_sk_alloc(sock_net(sk), sk->sk_family, GFP_ATOMIC,
> -					  sk->sk_prot, 0);
> -	struct llc_sock *newllc, *llc = llc_sk(sk);
> -
> -	if (!newsk)
> -		goto out;
> -	newllc = llc_sk(newsk);
> -	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
> -	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
> -	newllc->dev = dev;
> -	dev_hold(dev);
> -	llc_sap_add_socket(llc->sap, newsk);
> -out:
> -	return newsk;
> -}
> -
> -void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_addr saddr, daddr;
> -	struct sock *sk;
> -
> -	llc_pdu_decode_sa(skb, saddr.mac);
> -	llc_pdu_decode_ssap(skb, &saddr.lsap);
> -	llc_pdu_decode_da(skb, daddr.mac);
> -	llc_pdu_decode_dsap(skb, &daddr.lsap);
> -
> -	sk = __llc_lookup(sap, &saddr, &daddr, dev_net(skb->dev));
> -	if (!sk)
> -		goto drop;
> -
> -	bh_lock_sock(sk);
> -	/*
> -	 * This has to be done here and not at the upper layer ->accept
> -	 * method because of the way the PROCOM state machine works:
> -	 * it needs to set several state variables (see, for instance,
> -	 * llc_adm_actions_2 in net/llc/llc_c_st.c) and send a packet to
> -	 * the originator of the new connection, and this state has to be
> -	 * in the newly created struct sock private area. -acme
> -	 */
> -	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> -		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
> -							      &saddr, &daddr);
> -		if (!newsk)
> -			goto drop_unlock;
> -		skb_set_owner_r(skb, newsk);
> -	} else {
> -		/*
> -		 * Can't be skb_set_owner_r, this will be done at the
> -		 * llc_conn_state_process function, later on, when we will use
> -		 * skb_queue_rcv_skb to send it to upper layers, this is
> -		 * another trick required to cope with how the PROCOM state
> -		 * machine works. -acme
> -		 */
> -		skb_orphan(skb);
> -		sock_hold(sk);
> -		skb->sk = sk;
> -		skb->destructor = sock_efree;
> -	}
> -	if (!sock_owned_by_user(sk))
> -		llc_conn_rcv(sk, skb);
> -	else {
> -		dprintk("%s: adding to backlog...\n", __func__);
> -		llc_set_backlog_type(skb, LLC_PACKET);
> -		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
> -			goto drop_unlock;
> -	}
> -out:
> -	bh_unlock_sock(sk);
> -	sock_put(sk);
> -	return;
> -drop:
> -	kfree_skb(skb);
> -	return;
> -drop_unlock:
> -	kfree_skb(skb);
> -	goto out;
> -}
> -
> -#undef LLC_REFCNT_DEBUG
> -#ifdef LLC_REFCNT_DEBUG
> -static atomic_t llc_sock_nr;
> -#endif
> -
> -/**
> - *	llc_backlog_rcv - Processes rx frames and expired timers.
> - *	@sk: LLC sock (p8022 connection)
> - *	@skb: queued rx frame or event
> - *
> - *	This function processes frames that has received and timers that has
> - *	expired during sending an I pdu (refer to data_req_handler).  frames
> - *	queue by llc_rcv function (llc_mac.c) and timers queue by timer
> - *	callback functions(llc_c_ac.c).
> - */
> -static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> -{
> -	int rc = 0;
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
> -		if (likely(llc->state > 1)) /* not closed */
> -			rc = llc_conn_rcv(sk, skb);
> -		else
> -			goto out_kfree_skb;
> -	} else if (llc_backlog_type(skb) == LLC_EVENT) {
> -		/* timer expiration event */
> -		if (likely(llc->state > 1))  /* not closed */
> -			rc = llc_conn_state_process(sk, skb);
> -		else
> -			goto out_kfree_skb;
> -	} else {
> -		printk(KERN_ERR "%s: invalid skb in backlog\n", __func__);
> -		goto out_kfree_skb;
> -	}
> -out:
> -	return rc;
> -out_kfree_skb:
> -	kfree_skb(skb);
> -	goto out;
> -}
> -
> -/**
> - *     llc_sk_init - Initializes a socket with default llc values.
> - *     @sk: socket to initialize.
> - *
> - *     Initializes a socket with default llc values.
> - */
> -static void llc_sk_init(struct sock *sk)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc->state    = LLC_CONN_STATE_ADM;
> -	llc->inc_cntr = llc->dec_cntr = 2;
> -	llc->dec_step = llc->connect_step = 1;
> -
> -	timer_setup(&llc->ack_timer.timer, llc_conn_ack_tmr_cb, 0);
> -	llc->ack_timer.expire	      = sysctl_llc2_ack_timeout;
> -
> -	timer_setup(&llc->pf_cycle_timer.timer, llc_conn_pf_cycle_tmr_cb, 0);
> -	llc->pf_cycle_timer.expire	   = sysctl_llc2_p_timeout;
> -
> -	timer_setup(&llc->rej_sent_timer.timer, llc_conn_rej_tmr_cb, 0);
> -	llc->rej_sent_timer.expire	   = sysctl_llc2_rej_timeout;
> -
> -	timer_setup(&llc->busy_state_timer.timer, llc_conn_busy_tmr_cb, 0);
> -	llc->busy_state_timer.expire	     = sysctl_llc2_busy_timeout;
> -
> -	llc->n2 = 2;   /* max retransmit */
> -	llc->k  = 2;   /* tx win size, will adjust dynam */
> -	llc->rw = 128; /* rx win size (opt and equal to
> -			* tx_win of remote LLC) */
> -	skb_queue_head_init(&llc->pdu_unack_q);
> -	sk->sk_backlog_rcv = llc_backlog_rcv;
> -}
> -
> -/**
> - *	llc_sk_alloc - Allocates LLC sock
> - *	@net: network namespace
> - *	@family: upper layer protocol family
> - *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> - *	@prot: struct proto associated with this new sock instance
> - *	@kern: is this to be a kernel socket?
> - *
> - *	Allocates a LLC sock and initializes it. Returns the new LLC sock
> - *	or %NULL if there's no memory available for one
> - */
> -struct sock *llc_sk_alloc(struct net *net, int family, gfp_t priority, struct proto *prot, int kern)
> -{
> -	struct sock *sk = sk_alloc(net, family, priority, prot, kern);
> -
> -	if (!sk)
> -		goto out;
> -	llc_sk_init(sk);
> -	sock_init_data(NULL, sk);
> -#ifdef LLC_REFCNT_DEBUG
> -	atomic_inc(&llc_sock_nr);
> -	printk(KERN_DEBUG "LLC socket %p created in %s, now we have %d alive\n", sk,
> -		__func__, atomic_read(&llc_sock_nr));
> -#endif
> -out:
> -	return sk;
> -}
> -
> -void llc_sk_stop_all_timers(struct sock *sk, bool sync)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (sync) {
> -		timer_delete_sync(&llc->pf_cycle_timer.timer);
> -		timer_delete_sync(&llc->ack_timer.timer);
> -		timer_delete_sync(&llc->rej_sent_timer.timer);
> -		timer_delete_sync(&llc->busy_state_timer.timer);
> -	} else {
> -		timer_delete(&llc->pf_cycle_timer.timer);
> -		timer_delete(&llc->ack_timer.timer);
> -		timer_delete(&llc->rej_sent_timer.timer);
> -		timer_delete(&llc->busy_state_timer.timer);
> -	}
> -
> -	llc->ack_must_be_send = 0;
> -	llc->ack_pf = 0;
> -}
> -
> -/**
> - *	llc_sk_free - Frees a LLC socket
> - *	@sk: - socket to free
> - *
> - *	Frees a LLC socket
> - */
> -void llc_sk_free(struct sock *sk)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc->state = LLC_CONN_OUT_OF_SVC;
> -	/* Stop all (possibly) running timers */
> -	llc_sk_stop_all_timers(sk, true);
> -#ifdef DEBUG_LLC_CONN_ALLOC
> -	printk(KERN_INFO "%s: unackq=%d, txq=%d\n", __func__,
> -		skb_queue_len(&llc->pdu_unack_q),
> -		skb_queue_len(&sk->sk_write_queue));
> -#endif
> -	skb_queue_purge(&sk->sk_receive_queue);
> -	skb_queue_purge(&sk->sk_write_queue);
> -	skb_queue_purge(&llc->pdu_unack_q);
> -#ifdef LLC_REFCNT_DEBUG
> -	if (refcount_read(&sk->sk_refcnt) != 1) {
> -		printk(KERN_DEBUG "Destruction of LLC sock %p delayed in %s, cnt=%d\n",
> -			sk, __func__, refcount_read(&sk->sk_refcnt));
> -		printk(KERN_DEBUG "%d LLC sockets are still alive\n",
> -			atomic_read(&llc_sock_nr));
> -	} else {
> -		atomic_dec(&llc_sock_nr);
> -		printk(KERN_DEBUG "LLC socket %p released in %s, %d are still alive\n", sk,
> -			__func__, atomic_read(&llc_sock_nr));
> -	}
> -#endif
> -	sock_put(sk);
> -}
> -
> -/**
> - *	llc_sk_reset - resets a connection
> - *	@sk: LLC socket to reset
> - *
> - *	Resets a connection to the out of service state. Stops its timers
> - *	and frees any frames in the queues of the connection.
> - */
> -void llc_sk_reset(struct sock *sk)
> -{
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	llc_conn_ac_stop_all_timers(sk, NULL);
> -	skb_queue_purge(&sk->sk_write_queue);
> -	skb_queue_purge(&llc->pdu_unack_q);
> -	llc->remote_busy_flag	= 0;
> -	llc->cause_flag		= 0;
> -	llc->retry_count	= 0;
> -	llc_conn_set_p_flag(sk, 0);
> -	llc->f_flag		= 0;
> -	llc->s_flag		= 0;
> -	llc->ack_pf		= 0;
> -	llc->first_pdu_Ns	= 0;
> -	llc->ack_must_be_send	= 0;
> -	llc->dec_step		= 1;
> -	llc->inc_cntr		= 2;
> -	llc->dec_cntr		= 2;
> -	llc->X			= 0;
> -	llc->failed_data_req	= 0 ;
> -	llc->last_nr		= 0;
> -}
> diff --git a/net/llc/llc_if.c b/net/llc/llc_if.c
> deleted file mode 100644
> index 1514362e613d..000000000000
> --- a/net/llc/llc_if.c
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_if.c - Defines LLC interface to upper layer
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/gfp.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/netdevice.h>
> -#include <linux/errno.h>
> -#include <net/llc_if.h>
> -#include <net/llc_sap.h>
> -#include <net/llc_s_ev.h>
> -#include <net/llc_conn.h>
> -#include <net/sock.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_st.h>
> -#include <net/tcp_states.h>
> -
> -/**
> - *	llc_build_and_send_pkt - Connection data sending for upper layers.
> - *	@sk: connection
> - *	@skb: packet to send
> - *
> - *	This function is called when upper layer wants to send data using
> - *	connection oriented communication mode. During sending data, connection
> - *	will be locked and received frames and expired timers will be queued.
> - *	Returns 0 for success, -ECONNABORTED when the connection already
> - *	closed and -EBUSY when sending data is not permitted in this state or
> - *	LLC has send an I pdu with p bit set to 1 and is waiting for it's
> - *	response.
> - *
> - *	This function always consumes a reference to the skb.
> - */
> -int llc_build_and_send_pkt(struct sock *sk, struct sk_buff *skb)
> -{
> -	struct llc_conn_state_ev *ev;
> -	int rc = -ECONNABORTED;
> -	struct llc_sock *llc = llc_sk(sk);
> -
> -	if (unlikely(llc->state == LLC_CONN_STATE_ADM))
> -		goto out_free;
> -	rc = -EBUSY;
> -	if (unlikely(llc_data_accept_state(llc->state) || /* data_conn_refuse */
> -		     llc->p_flag)) {
> -		llc->failed_data_req = 1;
> -		goto out_free;
> -	}
> -	ev = llc_conn_ev(skb);
> -	ev->type      = LLC_CONN_EV_TYPE_PRIM;
> -	ev->prim      = LLC_DATA_PRIM;
> -	ev->prim_type = LLC_PRIM_TYPE_REQ;
> -	skb->dev      = llc->dev;
> -	return llc_conn_state_process(sk, skb);
> -
> -out_free:
> -	kfree_skb(skb);
> -	return rc;
> -}
> -
> -/**
> - *	llc_establish_connection - Called by upper layer to establish a conn
> - *	@sk: connection
> - *	@lmac: local mac address
> - *	@dmac: destination mac address
> - *	@dsap: destination sap
> - *
> - *	Upper layer calls this to establish an LLC connection with a remote
> - *	machine. This function packages a proper event and sends it connection
> - *	component state machine. Success or failure of connection
> - *	establishment will inform to upper layer via calling it's confirm
> - *	function and passing proper information.
> - */
> -int llc_establish_connection(struct sock *sk, const u8 *lmac, u8 *dmac, u8 dsap)
> -{
> -	int rc = -EISCONN;
> -	struct llc_addr laddr, daddr;
> -	struct sk_buff *skb;
> -	struct llc_sock *llc = llc_sk(sk);
> -	struct sock *existing;
> -
> -	laddr.lsap = llc->sap->laddr.lsap;
> -	daddr.lsap = dsap;
> -	memcpy(daddr.mac, dmac, sizeof(daddr.mac));
> -	memcpy(laddr.mac, lmac, sizeof(laddr.mac));
> -	existing = llc_lookup_established(llc->sap, &daddr, &laddr, sock_net(sk));
> -	if (existing) {
> -		if (existing->sk_state == TCP_ESTABLISHED) {
> -			sk = existing;
> -			goto out_put;
> -		} else
> -			sock_put(existing);
> -	}
> -	sock_hold(sk);
> -	rc = -ENOMEM;
> -	skb = alloc_skb(0, GFP_ATOMIC);
> -	if (skb) {
> -		struct llc_conn_state_ev *ev = llc_conn_ev(skb);
> -
> -		ev->type      = LLC_CONN_EV_TYPE_PRIM;
> -		ev->prim      = LLC_CONN_PRIM;
> -		ev->prim_type = LLC_PRIM_TYPE_REQ;
> -		skb_set_owner_w(skb, sk);
> -		rc = llc_conn_state_process(sk, skb);
> -	}
> -out_put:
> -	sock_put(sk);
> -	return rc;
> -}
> -
> -/**
> - *	llc_send_disc - Called by upper layer to close a connection
> - *	@sk: connection to be closed
> - *
> - *	Upper layer calls this when it wants to close an established LLC
> - *	connection with a remote machine. This function packages a proper event
> - *	and sends it to connection component state machine. Returns 0 for
> - *	success, 1 otherwise.
> - */
> -int llc_send_disc(struct sock *sk)
> -{
> -	u16 rc = 1;
> -	struct llc_conn_state_ev *ev;
> -	struct sk_buff *skb;
> -
> -	sock_hold(sk);
> -	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_ESTABLISHED ||
> -	    llc_sk(sk)->state == LLC_CONN_STATE_ADM ||
> -	    llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC)
> -		goto out;
> -	/*
> -	 * Postpone unassigning the connection from its SAP and returning the
> -	 * connection until all ACTIONs have been completely executed
> -	 */
> -	skb = alloc_skb(0, GFP_ATOMIC);
> -	if (!skb)
> -		goto out;
> -	skb_set_owner_w(skb, sk);
> -	sk->sk_state  = TCP_CLOSING;
> -	ev	      = llc_conn_ev(skb);
> -	ev->type      = LLC_CONN_EV_TYPE_PRIM;
> -	ev->prim      = LLC_DISC_PRIM;
> -	ev->prim_type = LLC_PRIM_TYPE_REQ;
> -	rc = llc_conn_state_process(sk, skb);
> -out:
> -	sock_put(sk);
> -	return rc;
> -}
> diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
> index 8eb3d73c39d1..78426ae7c73f 100644
> --- a/net/llc/llc_input.c
> +++ b/net/llc/llc_input.c
> @@ -11,7 +11,6 @@
>  #include <net/net_namespace.h>
>  #include <net/llc.h>
>  #include <net/llc_pdu.h>
> -#include <net/llc_sap.h>
>  
>  #if 0
>  #define dprintk(args...) printk(KERN_DEBUG args)
> diff --git a/net/llc/llc_pdu.c b/net/llc/llc_pdu.c
> deleted file mode 100644
> index c1938fa24a3f..000000000000
> --- a/net/llc/llc_pdu.c
> +++ /dev/null
> @@ -1,366 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_pdu.c - access to PDU internals
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/netdevice.h>
> -#include <net/llc_pdu.h>
> -
> -static void llc_pdu_decode_pdu_type(struct sk_buff *skb, u8 *type);
> -static u8 llc_pdu_get_pf_bit(struct llc_pdu_sn *pdu);
> -
> -void llc_pdu_set_cmd_rsp(struct sk_buff *skb, u8 pdu_type)
> -{
> -	llc_pdu_un_hdr(skb)->ssap |= pdu_type;
> -}
> -
> -/**
> - *	llc_pdu_set_pf_bit - sets poll/final bit in LLC header
> - *	@skb: Frame to set bit in
> - *	@bit_value: poll/final bit (0 or 1).
> - *
> - *	This function sets poll/final bit in LLC header (based on type of PDU).
> - *	in I or S pdus, p/f bit is right bit of fourth byte in header. in U
> - *	pdus p/f bit is fifth bit of third byte.
> - */
> -void llc_pdu_set_pf_bit(struct sk_buff *skb, u8 bit_value)
> -{
> -	u8 pdu_type;
> -	struct llc_pdu_sn *pdu;
> -
> -	llc_pdu_decode_pdu_type(skb, &pdu_type);
> -	pdu = llc_pdu_sn_hdr(skb);
> -
> -	switch (pdu_type) {
> -	case LLC_PDU_TYPE_I:
> -	case LLC_PDU_TYPE_S:
> -		pdu->ctrl_2 = (pdu->ctrl_2 & 0xFE) | bit_value;
> -		break;
> -	case LLC_PDU_TYPE_U:
> -		pdu->ctrl_1 |= (pdu->ctrl_1 & 0xEF) | (bit_value << 4);
> -		break;
> -	}
> -}
> -
> -/**
> - *	llc_pdu_decode_pf_bit - extracs poll/final bit from LLC header
> - *	@skb: input skb that p/f bit must be extracted from it
> - *	@pf_bit: poll/final bit (0 or 1)
> - *
> - *	This function extracts poll/final bit from LLC header (based on type of
> - *	PDU). In I or S pdus, p/f bit is right bit of fourth byte in header. In
> - *	U pdus p/f bit is fifth bit of third byte.
> - */
> -void llc_pdu_decode_pf_bit(struct sk_buff *skb, u8 *pf_bit)
> -{
> -	u8 pdu_type;
> -	struct llc_pdu_sn *pdu;
> -
> -	llc_pdu_decode_pdu_type(skb, &pdu_type);
> -	pdu = llc_pdu_sn_hdr(skb);
> -
> -	switch (pdu_type) {
> -	case LLC_PDU_TYPE_I:
> -	case LLC_PDU_TYPE_S:
> -		*pf_bit = pdu->ctrl_2 & LLC_S_PF_BIT_MASK;
> -		break;
> -	case LLC_PDU_TYPE_U:
> -		*pf_bit = (pdu->ctrl_1 & LLC_U_PF_BIT_MASK) >> 4;
> -		break;
> -	}
> -}
> -
> -/**
> - *	llc_pdu_init_as_disc_cmd - Builds DISC PDU
> - *	@skb: Address of the skb to build
> - *	@p_bit: The P bit to set in the PDU
> - *
> - *	Builds a pdu frame as a DISC command.
> - */
> -void llc_pdu_init_as_disc_cmd(struct sk_buff *skb, u8 p_bit)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_U;
> -	pdu->ctrl_1 |= LLC_2_PDU_CMD_DISC;
> -	pdu->ctrl_1 |= ((p_bit & 1) << 4) & LLC_U_PF_BIT_MASK;
> -}
> -
> -/**
> - *	llc_pdu_init_as_i_cmd - builds I pdu
> - *	@skb: Address of the skb to build
> - *	@p_bit: The P bit to set in the PDU
> - *	@ns: The sequence number of the data PDU
> - *	@nr: The seq. number of the expected I PDU from the remote
> - *
> - *	Builds a pdu frame as an I command.
> - */
> -void llc_pdu_init_as_i_cmd(struct sk_buff *skb, u8 p_bit, u8 ns, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_I;
> -	pdu->ctrl_2  = 0;
> -	pdu->ctrl_2 |= (p_bit & LLC_I_PF_BIT_MASK); /* p/f bit */
> -	pdu->ctrl_1 |= (ns << 1) & 0xFE;   /* set N(S) in bits 2..8 */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE;   /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_rej_cmd - builds REJ PDU
> - *	@skb: Address of the skb to build
> - *	@p_bit: The P bit to set in the PDU
> - *	@nr: The seq. number of the expected I PDU from the remote
> - *
> - *	Builds a pdu frame as a REJ command.
> - */
> -void llc_pdu_init_as_rej_cmd(struct sk_buff *skb, u8 p_bit, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_S;
> -	pdu->ctrl_1 |= LLC_2_PDU_CMD_REJ;
> -	pdu->ctrl_2  = 0;
> -	pdu->ctrl_2 |= p_bit & LLC_S_PF_BIT_MASK;
> -	pdu->ctrl_1 &= 0x0F;    /* setting bits 5..8 to zero(reserved) */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE; /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_rnr_cmd - builds RNR pdu
> - *	@skb: Address of the skb to build
> - *	@p_bit: The P bit to set in the PDU
> - *	@nr: The seq. number of the expected I PDU from the remote
> - *
> - *	Builds a pdu frame as an RNR command.
> - */
> -void llc_pdu_init_as_rnr_cmd(struct sk_buff *skb, u8 p_bit, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_S;
> -	pdu->ctrl_1 |= LLC_2_PDU_CMD_RNR;
> -	pdu->ctrl_2  = 0;
> -	pdu->ctrl_2 |= p_bit & LLC_S_PF_BIT_MASK;
> -	pdu->ctrl_1 &= 0x0F;    /* setting bits 5..8 to zero(reserved) */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE; /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_rr_cmd - Builds RR pdu
> - *	@skb: Address of the skb to build
> - *	@p_bit: The P bit to set in the PDU
> - *	@nr: The seq. number of the expected I PDU from the remote
> - *
> - *	Builds a pdu frame as an RR command.
> - */
> -void llc_pdu_init_as_rr_cmd(struct sk_buff *skb, u8 p_bit, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_S;
> -	pdu->ctrl_1 |= LLC_2_PDU_CMD_RR;
> -	pdu->ctrl_2  = p_bit & LLC_S_PF_BIT_MASK;
> -	pdu->ctrl_1 &= 0x0F;    /* setting bits 5..8 to zero(reserved) */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE; /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_sabme_cmd - builds SABME pdu
> - *	@skb: Address of the skb to build
> - *	@p_bit: The P bit to set in the PDU
> - *
> - *	Builds a pdu frame as an SABME command.
> - */
> -void llc_pdu_init_as_sabme_cmd(struct sk_buff *skb, u8 p_bit)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_U;
> -	pdu->ctrl_1 |= LLC_2_PDU_CMD_SABME;
> -	pdu->ctrl_1 |= ((p_bit & 1) << 4) & LLC_U_PF_BIT_MASK;
> -}
> -
> -/**
> - *	llc_pdu_init_as_dm_rsp - builds DM response pdu
> - *	@skb: Address of the skb to build
> - *	@f_bit: The F bit to set in the PDU
> - *
> - *	Builds a pdu frame as a DM response.
> - */
> -void llc_pdu_init_as_dm_rsp(struct sk_buff *skb, u8 f_bit)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_U;
> -	pdu->ctrl_1 |= LLC_2_PDU_RSP_DM;
> -	pdu->ctrl_1 |= ((f_bit & 1) << 4) & LLC_U_PF_BIT_MASK;
> -}
> -
> -/**
> - *	llc_pdu_init_as_frmr_rsp - builds FRMR response PDU
> - *	@skb: Address of the frame to build
> - *	@prev_pdu: The rejected PDU frame
> - *	@f_bit: The F bit to set in the PDU
> - *	@vs: tx state vari value for the data link conn at the rejecting LLC
> - *	@vr: rx state var value for the data link conn at the rejecting LLC
> - *	@vzyxw: completely described in the IEEE Std 802.2 document (Pg 55)
> - *
> - *	Builds a pdu frame as a FRMR response.
> - */
> -void llc_pdu_init_as_frmr_rsp(struct sk_buff *skb, struct llc_pdu_sn *prev_pdu,
> -			      u8 f_bit, u8 vs, u8 vr, u8 vzyxw)
> -{
> -	struct llc_frmr_info *frmr_info;
> -	u8 prev_pf = 0;
> -	u8 *ctrl;
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_U;
> -	pdu->ctrl_1 |= LLC_2_PDU_RSP_FRMR;
> -	pdu->ctrl_1 |= ((f_bit & 1) << 4) & LLC_U_PF_BIT_MASK;
> -
> -	frmr_info = (struct llc_frmr_info *)&pdu->ctrl_2;
> -	ctrl = (u8 *)&prev_pdu->ctrl_1;
> -	FRMR_INFO_SET_REJ_CNTRL(frmr_info,ctrl);
> -	FRMR_INFO_SET_Vs(frmr_info, vs);
> -	FRMR_INFO_SET_Vr(frmr_info, vr);
> -	prev_pf = llc_pdu_get_pf_bit(prev_pdu);
> -	FRMR_INFO_SET_C_R_BIT(frmr_info, prev_pf);
> -	FRMR_INFO_SET_INVALID_PDU_CTRL_IND(frmr_info, vzyxw);
> -	FRMR_INFO_SET_INVALID_PDU_INFO_IND(frmr_info, vzyxw);
> -	FRMR_INFO_SET_PDU_INFO_2LONG_IND(frmr_info, vzyxw);
> -	FRMR_INFO_SET_PDU_INVALID_Nr_IND(frmr_info, vzyxw);
> -	FRMR_INFO_SET_PDU_INVALID_Ns_IND(frmr_info, vzyxw);
> -	skb_put(skb, sizeof(struct llc_frmr_info));
> -}
> -
> -/**
> - *	llc_pdu_init_as_rr_rsp - builds RR response pdu
> - *	@skb: Address of the skb to build
> - *	@f_bit: The F bit to set in the PDU
> - *	@nr: The seq. number of the expected data PDU from the remote
> - *
> - *	Builds a pdu frame as an RR response.
> - */
> -void llc_pdu_init_as_rr_rsp(struct sk_buff *skb, u8 f_bit, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_S;
> -	pdu->ctrl_1 |= LLC_2_PDU_RSP_RR;
> -	pdu->ctrl_2  = 0;
> -	pdu->ctrl_2 |= f_bit & LLC_S_PF_BIT_MASK;
> -	pdu->ctrl_1 &= 0x0F;    /* setting bits 5..8 to zero(reserved) */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE;  /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_rej_rsp - builds REJ response pdu
> - *	@skb: Address of the skb to build
> - *	@f_bit: The F bit to set in the PDU
> - *	@nr: The seq. number of the expected data PDU from the remote
> - *
> - *	Builds a pdu frame as a REJ response.
> - */
> -void llc_pdu_init_as_rej_rsp(struct sk_buff *skb, u8 f_bit, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_S;
> -	pdu->ctrl_1 |= LLC_2_PDU_RSP_REJ;
> -	pdu->ctrl_2  = 0;
> -	pdu->ctrl_2 |= f_bit & LLC_S_PF_BIT_MASK;
> -	pdu->ctrl_1 &= 0x0F;    /* setting bits 5..8 to zero(reserved) */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE;  /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_rnr_rsp - builds RNR response pdu
> - *	@skb: Address of the frame to build
> - *	@f_bit: The F bit to set in the PDU
> - *	@nr: The seq. number of the expected data PDU from the remote
> - *
> - *	Builds a pdu frame as an RNR response.
> - */
> -void llc_pdu_init_as_rnr_rsp(struct sk_buff *skb, u8 f_bit, u8 nr)
> -{
> -	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_S;
> -	pdu->ctrl_1 |= LLC_2_PDU_RSP_RNR;
> -	pdu->ctrl_2  = 0;
> -	pdu->ctrl_2 |= f_bit & LLC_S_PF_BIT_MASK;
> -	pdu->ctrl_1 &= 0x0F;    /* setting bits 5..8 to zero(reserved) */
> -	pdu->ctrl_2 |= (nr << 1) & 0xFE;  /* set N(R) in bits 10..16 */
> -}
> -
> -/**
> - *	llc_pdu_init_as_ua_rsp - builds UA response pdu
> - *	@skb: Address of the frame to build
> - *	@f_bit: The F bit to set in the PDU
> - *
> - *	Builds a pdu frame as a UA response.
> - */
> -void llc_pdu_init_as_ua_rsp(struct sk_buff *skb, u8 f_bit)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	pdu->ctrl_1  = LLC_PDU_TYPE_U;
> -	pdu->ctrl_1 |= LLC_2_PDU_RSP_UA;
> -	pdu->ctrl_1 |= ((f_bit & 1) << 4) & LLC_U_PF_BIT_MASK;
> -}
> -
> -/**
> - *	llc_pdu_decode_pdu_type - designates PDU type
> - *	@skb: input skb that type of it must be designated.
> - *	@type: type of PDU (output argument).
> - *
> - *	This function designates type of PDU (I, S or U).
> - */
> -static void llc_pdu_decode_pdu_type(struct sk_buff *skb, u8 *type)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	if (pdu->ctrl_1 & 1) {
> -		if ((pdu->ctrl_1 & LLC_PDU_TYPE_U) == LLC_PDU_TYPE_U)
> -			*type = LLC_PDU_TYPE_U;
> -		else
> -			*type = LLC_PDU_TYPE_S;
> -	} else
> -		*type = LLC_PDU_TYPE_I;
> -}
> -
> -/**
> - *	llc_pdu_get_pf_bit - extracts p/f bit of input PDU
> - *	@pdu: pointer to LLC header.
> - *
> - *	This function extracts p/f bit of input PDU. at first examines type of
> - *	PDU and then extracts p/f bit. Returns the p/f bit.
> - */
> -static u8 llc_pdu_get_pf_bit(struct llc_pdu_sn *pdu)
> -{
> -	u8 pdu_type;
> -	u8 pf_bit = 0;
> -
> -	if (pdu->ctrl_1 & 1) {
> -		if ((pdu->ctrl_1 & LLC_PDU_TYPE_U) == LLC_PDU_TYPE_U)
> -			pdu_type = LLC_PDU_TYPE_U;
> -		else
> -			pdu_type = LLC_PDU_TYPE_S;
> -	} else
> -		pdu_type = LLC_PDU_TYPE_I;
> -	switch (pdu_type) {
> -	case LLC_PDU_TYPE_I:
> -	case LLC_PDU_TYPE_S:
> -		pf_bit = pdu->ctrl_2 & LLC_S_PF_BIT_MASK;
> -		break;
> -	case LLC_PDU_TYPE_U:
> -		pf_bit = (pdu->ctrl_1 & LLC_U_PF_BIT_MASK) >> 4;
> -		break;
> -	}
> -	return pf_bit;
> -}
> diff --git a/net/llc/llc_proc.c b/net/llc/llc_proc.c
> deleted file mode 100644
> index 4804a08c2490..000000000000
> --- a/net/llc/llc_proc.c
> +++ /dev/null
> @@ -1,245 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * proc_llc.c - proc interface for LLC
> - *
> - * Copyright (c) 2001 by Jay Schulist <jschlst@samba.org>
> - *		 2002-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/proc_fs.h>
> -#include <linux/errno.h>
> -#include <linux/seq_file.h>
> -#include <linux/export.h>
> -#include <net/net_namespace.h>
> -#include <net/sock.h>
> -#include <net/llc.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_c_st.h>
> -#include <net/llc_conn.h>
> -
> -static void llc_ui_format_mac(struct seq_file *seq, const u8 *addr)
> -{
> -	seq_printf(seq, "%pM", addr);
> -}
> -
> -static struct sock *llc_get_sk_idx(loff_t pos)
> -{
> -	struct llc_sap *sap;
> -	struct sock *sk = NULL;
> -	int i;
> -
> -	list_for_each_entry_rcu(sap, &llc_sap_list, node) {
> -		spin_lock_bh(&sap->sk_lock);
> -		for (i = 0; i < LLC_SK_LADDR_HASH_ENTRIES; i++) {
> -			struct hlist_nulls_head *head = &sap->sk_laddr_hash[i];
> -			struct hlist_nulls_node *node;
> -
> -			sk_nulls_for_each(sk, node, head) {
> -				if (!pos)
> -					goto found; /* keep the lock */
> -				--pos;
> -			}
> -		}
> -		spin_unlock_bh(&sap->sk_lock);
> -	}
> -	sk = NULL;
> -found:
> -	return sk;
> -}
> -
> -static void *llc_seq_start(struct seq_file *seq, loff_t *pos) __acquires(RCU)
> -{
> -	loff_t l = *pos;
> -
> -	rcu_read_lock_bh();
> -	return l ? llc_get_sk_idx(--l) : SEQ_START_TOKEN;
> -}
> -
> -static struct sock *laddr_hash_next(struct llc_sap *sap, int bucket)
> -{
> -	struct hlist_nulls_node *node;
> -	struct sock *sk = NULL;
> -
> -	while (++bucket < LLC_SK_LADDR_HASH_ENTRIES)
> -		sk_nulls_for_each(sk, node, &sap->sk_laddr_hash[bucket])
> -			goto out;
> -
> -out:
> -	return sk;
> -}
> -
> -static void *llc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> -{
> -	struct sock* sk, *next;
> -	struct llc_sock *llc;
> -	struct llc_sap *sap;
> -
> -	++*pos;
> -	if (v == SEQ_START_TOKEN) {
> -		sk = llc_get_sk_idx(0);
> -		goto out;
> -	}
> -	sk = v;
> -	next = sk_nulls_next(sk);
> -	if (next) {
> -		sk = next;
> -		goto out;
> -	}
> -	llc = llc_sk(sk);
> -	sap = llc->sap;
> -	sk = laddr_hash_next(sap, llc_sk_laddr_hashfn(sap, &llc->laddr));
> -	if (sk)
> -		goto out;
> -	spin_unlock_bh(&sap->sk_lock);
> -	list_for_each_entry_continue_rcu(sap, &llc_sap_list, node) {
> -		spin_lock_bh(&sap->sk_lock);
> -		sk = laddr_hash_next(sap, -1);
> -		if (sk)
> -			break; /* keep the lock */
> -		spin_unlock_bh(&sap->sk_lock);
> -	}
> -out:
> -	return sk;
> -}
> -
> -static void llc_seq_stop(struct seq_file *seq, void *v)
> -{
> -	if (v && v != SEQ_START_TOKEN) {
> -		struct sock *sk = v;
> -		struct llc_sock *llc = llc_sk(sk);
> -		struct llc_sap *sap = llc->sap;
> -
> -		spin_unlock_bh(&sap->sk_lock);
> -	}
> -	rcu_read_unlock_bh();
> -}
> -
> -static int llc_seq_socket_show(struct seq_file *seq, void *v)
> -{
> -	struct sock* sk;
> -	struct llc_sock *llc;
> -
> -	if (v == SEQ_START_TOKEN) {
> -		seq_puts(seq, "SKt Mc local_mac_sap        remote_mac_sap   "
> -			      "    tx_queue rx_queue st uid link\n");
> -		goto out;
> -	}
> -	sk = v;
> -	llc = llc_sk(sk);
> -
> -	/* FIXME: check if the address is multicast */
> -	seq_printf(seq, "%2X  %2X ", sk->sk_type, 0);
> -
> -	if (llc->dev)
> -		llc_ui_format_mac(seq, llc->dev->dev_addr);
> -	else {
> -		u8 addr[6] = {0,0,0,0,0,0};
> -		llc_ui_format_mac(seq, addr);
> -	}
> -	seq_printf(seq, "@%02X ", llc->sap->laddr.lsap);
> -	llc_ui_format_mac(seq, llc->daddr.mac);
> -	seq_printf(seq, "@%02X %8d %8d %2d %3u %4d\n", llc->daddr.lsap,
> -		   sk_wmem_alloc_get(sk),
> -		   sk_rmem_alloc_get(sk) - llc->copied_seq,
> -		   sk->sk_state,
> -		   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
> -		   llc->link);
> -out:
> -	return 0;
> -}
> -
> -static const char *const llc_conn_state_names[] = {
> -	[LLC_CONN_STATE_ADM] =        "adm",
> -	[LLC_CONN_STATE_SETUP] =      "setup",
> -	[LLC_CONN_STATE_NORMAL] =     "normal",
> -	[LLC_CONN_STATE_BUSY] =       "busy",
> -	[LLC_CONN_STATE_REJ] =        "rej",
> -	[LLC_CONN_STATE_AWAIT] =      "await",
> -	[LLC_CONN_STATE_AWAIT_BUSY] = "await_busy",
> -	[LLC_CONN_STATE_AWAIT_REJ] =  "await_rej",
> -	[LLC_CONN_STATE_D_CONN]	=     "d_conn",
> -	[LLC_CONN_STATE_RESET] =      "reset",
> -	[LLC_CONN_STATE_ERROR] =      "error",
> -	[LLC_CONN_STATE_TEMP] =       "temp",
> -};
> -
> -static int llc_seq_core_show(struct seq_file *seq, void *v)
> -{
> -	struct sock* sk;
> -	struct llc_sock *llc;
> -
> -	if (v == SEQ_START_TOKEN) {
> -		seq_puts(seq, "Connection list:\n"
> -			      "dsap state      retr txw rxw pf ff sf df rs cs "
> -			      "tack tpfc trs tbs blog busr\n");
> -		goto out;
> -	}
> -	sk = v;
> -	llc = llc_sk(sk);
> -
> -	seq_printf(seq, " %02X  %-10s %3d  %3d %3d %2d %2d %2d %2d %2d %2d "
> -			"%4d %4d %3d %3d %4d %4d\n",
> -		   llc->daddr.lsap, llc_conn_state_names[llc->state],
> -		   llc->retry_count, llc->k, llc->rw, llc->p_flag, llc->f_flag,
> -		   llc->s_flag, llc->data_flag, llc->remote_busy_flag,
> -		   llc->cause_flag, timer_pending(&llc->ack_timer.timer),
> -		   timer_pending(&llc->pf_cycle_timer.timer),
> -		   timer_pending(&llc->rej_sent_timer.timer),
> -		   timer_pending(&llc->busy_state_timer.timer),
> -		   !!sk->sk_backlog.tail, sock_owned_by_user_nocheck(sk));
> -out:
> -	return 0;
> -}
> -
> -static const struct seq_operations llc_seq_socket_ops = {
> -	.start  = llc_seq_start,
> -	.next   = llc_seq_next,
> -	.stop   = llc_seq_stop,
> -	.show   = llc_seq_socket_show,
> -};
> -
> -static const struct seq_operations llc_seq_core_ops = {
> -	.start  = llc_seq_start,
> -	.next   = llc_seq_next,
> -	.stop   = llc_seq_stop,
> -	.show   = llc_seq_core_show,
> -};
> -
> -static struct proc_dir_entry *llc_proc_dir;
> -
> -int __init llc_proc_init(void)
> -{
> -	int rc = -ENOMEM;
> -	struct proc_dir_entry *p;
> -
> -	llc_proc_dir = proc_mkdir("llc", init_net.proc_net);
> -	if (!llc_proc_dir)
> -		goto out;
> -
> -	p = proc_create_seq("socket", 0444, llc_proc_dir, &llc_seq_socket_ops);
> -	if (!p)
> -		goto out_socket;
> -
> -	p = proc_create_seq("core", 0444, llc_proc_dir, &llc_seq_core_ops);
> -	if (!p)
> -		goto out_core;
> -
> -	rc = 0;
> -out:
> -	return rc;
> -out_core:
> -	remove_proc_entry("socket", llc_proc_dir);
> -out_socket:
> -	remove_proc_entry("llc", init_net.proc_net);
> -	goto out;
> -}
> -
> -void llc_proc_exit(void)
> -{
> -	remove_proc_entry("socket", llc_proc_dir);
> -	remove_proc_entry("core", llc_proc_dir);
> -	remove_proc_entry("llc", init_net.proc_net);
> -}
> diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
> deleted file mode 100644
> index 831998211b52..000000000000
> --- a/net/llc/llc_s_ac.c
> +++ /dev/null
> @@ -1,220 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_s_ac.c - actions performed during sap state transition.
> - *
> - * Description :
> - *   Functions in this module are implementation of sap component actions.
> - *   Details of actions can be found in IEEE-802.2 standard document.
> - *   All functions have one sap and one event as input argument. All of
> - *   them return 0 On success and 1 otherwise.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/netdevice.h>
> -#include <net/llc.h>
> -#include <net/llc_pdu.h>
> -#include <net/llc_s_ac.h>
> -#include <net/llc_s_ev.h>
> -#include <net/llc_sap.h>
> -#include <net/sock.h>
> -
> -/**
> - *	llc_sap_action_unitdata_ind - forward UI PDU to network layer
> - *	@sap: SAP
> - *	@skb: the event to forward
> - *
> - *	Received a UI PDU from MAC layer; forward to network layer as a
> - *	UNITDATA INDICATION; verify our event is the kind we expect
> - */
> -int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	llc_sap_rtn_pdu(sap, skb);
> -	return 0;
> -}
> -
> -static int llc_prepare_and_xmit(struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct sk_buff *nskb;
> -	int rc;
> -
> -	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
> -	if (rc)
> -		return rc;
> -
> -	nskb = skb_clone(skb, GFP_ATOMIC);
> -	if (!nskb)
> -		return -ENOMEM;
> -
> -	if (skb->sk)
> -		skb_set_owner_w(nskb, skb->sk);
> -
> -	return dev_queue_xmit(nskb);
> -}
> -
> -/**
> - *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Sends a UI PDU to the MAC layer in response to a UNITDATA REQUEST
> - *	primitive from the network layer. Verifies event is a primitive type of
> - *	event. Verify the primitive is a UNITDATA REQUEST.
> - */
> -int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
> -			    ev->daddr.lsap, LLC_PDU_CMD);
> -	llc_pdu_init_as_ui_cmd(skb);
> -
> -	return llc_prepare_and_xmit(skb);
> -}
> -
> -/**
> - *	llc_sap_action_send_xid_c - send XID PDU as response to XID REQ
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Send a XID command PDU to MAC layer in response to a XID REQUEST
> - *	primitive from the network layer. Verify event is a primitive type
> - *	event. Verify the primitive is a XID REQUEST.
> - */
> -int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
> -			    ev->daddr.lsap, LLC_PDU_CMD);
> -	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
> -
> -	return llc_prepare_and_xmit(skb);
> -}
> -
> -/**
> - *	llc_sap_action_send_xid_r - send XID PDU resp to MAC for received XID
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Send XID response PDU to MAC in response to an earlier received XID
> - *	command PDU. Verify event is a PDU type event
> - */
> -int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	u8 mac_da[ETH_ALEN], mac_sa[ETH_ALEN], dsap;
> -	int rc = 1;
> -	struct sk_buff *nskb;
> -
> -	llc_pdu_decode_sa(skb, mac_da);
> -	llc_pdu_decode_da(skb, mac_sa);
> -	llc_pdu_decode_ssap(skb, &dsap);
> -	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U,
> -			       sizeof(struct llc_xid_info));
> -	if (!nskb)
> -		goto out;
> -	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap, dsap,
> -			    LLC_PDU_RSP);
> -	llc_pdu_init_as_xid_rsp(nskb, LLC_XID_NULL_CLASS_2, 0);
> -	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
> -	if (likely(!rc))
> -		rc = dev_queue_xmit(nskb);
> -	else
> -		kfree_skb(nskb);
> -out:
> -	return rc;
> -}
> -
> -/**
> - *	llc_sap_action_send_test_c - send TEST PDU to MAC in resp to TEST REQ
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Send a TEST command PDU to the MAC layer in response to a TEST REQUEST
> - *	primitive from the network layer. Verify event is a primitive type
> - *	event; verify the primitive is a TEST REQUEST.
> - */
> -int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
> -			    ev->daddr.lsap, LLC_PDU_CMD);
> -	llc_pdu_init_as_test_cmd(skb);
> -
> -	return llc_prepare_and_xmit(skb);
> -}
> -
> -int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	u8 mac_da[ETH_ALEN], mac_sa[ETH_ALEN], dsap;
> -	struct sk_buff *nskb;
> -	int rc = 1;
> -	u32 data_size;
> -
> -	if (skb->mac_len < ETH_HLEN)
> -		return 1;
> -
> -	llc_pdu_decode_sa(skb, mac_da);
> -	llc_pdu_decode_da(skb, mac_sa);
> -	llc_pdu_decode_ssap(skb, &dsap);
> -
> -	/* The test request command is type U (llc_len = 3) */
> -	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
> -	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
> -	if (!nskb)
> -		goto out;
> -	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap, dsap,
> -			    LLC_PDU_RSP);
> -	llc_pdu_init_as_test_rsp(nskb, skb);
> -	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
> -	if (likely(!rc))
> -		rc = dev_queue_xmit(nskb);
> -	else
> -		kfree_skb(nskb);
> -out:
> -	return rc;
> -}
> -
> -/**
> - *	llc_sap_action_report_status - report data link status to layer mgmt
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Report data link status to layer management. Verify our event is the
> - *	kind we expect.
> - */
> -int llc_sap_action_report_status(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	return 0;
> -}
> -
> -/**
> - *	llc_sap_action_xid_ind - send XID PDU resp to net layer via XID IND
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Send a XID response PDU to the network layer via a XID INDICATION
> - *	primitive.
> - */
> -int llc_sap_action_xid_ind(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	llc_sap_rtn_pdu(sap, skb);
> -	return 0;
> -}
> -
> -/**
> - *	llc_sap_action_test_ind - send TEST PDU to net layer via TEST IND
> - *	@sap: SAP
> - *	@skb: the event to send
> - *
> - *	Send a TEST response PDU to the network layer via a TEST INDICATION
> - *	primitive. Verify our event is a PDU type event.
> - */
> -int llc_sap_action_test_ind(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	llc_sap_rtn_pdu(sap, skb);
> -	return 0;
> -}
> diff --git a/net/llc/llc_s_ev.c b/net/llc/llc_s_ev.c
> deleted file mode 100644
> index cfbecba589e7..000000000000
> --- a/net/llc/llc_s_ev.c
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_s_ev.c - Defines SAP component events
> - *
> - * The followed event functions are SAP component events which are described
> - * in 802.2 LLC protocol standard document.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/socket.h>
> -#include <net/sock.h>
> -#include <net/llc_if.h>
> -#include <net/llc_s_ev.h>
> -#include <net/llc_pdu.h>
> -
> -int llc_sap_ev_activation_req(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_SIMPLE &&
> -	       ev->prim_type == LLC_SAP_EV_ACTIVATION_REQ ? 0 : 1;
> -}
> -
> -int llc_sap_ev_rx_ui(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PDU && LLC_PDU_IS_CMD(pdu) &&
> -	       LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_UI ? 0 : 1;
> -}
> -
> -int llc_sap_ev_unitdata_req(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PRIM &&
> -	       ev->prim == LLC_DATAUNIT_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -
> -}
> -
> -int llc_sap_ev_xid_req(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PRIM &&
> -	       ev->prim == LLC_XID_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -}
> -
> -int llc_sap_ev_rx_xid_c(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PDU && LLC_PDU_IS_CMD(pdu) &&
> -	       LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID ? 0 : 1;
> -}
> -
> -int llc_sap_ev_rx_xid_r(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PDU && LLC_PDU_IS_RSP(pdu) &&
> -	       LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_RSP(pdu) == LLC_1_PDU_CMD_XID ? 0 : 1;
> -}
> -
> -int llc_sap_ev_test_req(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PRIM &&
> -	       ev->prim == LLC_TEST_PRIM &&
> -	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
> -}
> -
> -int llc_sap_ev_rx_test_c(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PDU && LLC_PDU_IS_CMD(pdu) &&
> -	       LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_TEST ? 0 : 1;
> -}
> -
> -int llc_sap_ev_rx_test_r(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_PDU && LLC_PDU_IS_RSP(pdu) &&
> -	       LLC_PDU_TYPE_IS_U(pdu) &&
> -	       LLC_U_PDU_RSP(pdu) == LLC_1_PDU_CMD_TEST ? 0 : 1;
> -}
> -
> -int llc_sap_ev_deactivation_req(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	return ev->type == LLC_SAP_EV_TYPE_SIMPLE &&
> -	       ev->prim_type == LLC_SAP_EV_DEACTIVATION_REQ ? 0 : 1;
> -}
> diff --git a/net/llc/llc_s_st.c b/net/llc/llc_s_st.c
> deleted file mode 100644
> index e14d4f520327..000000000000
> --- a/net/llc/llc_s_st.c
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_s_st.c - Defines SAP component state machine transitions.
> - *
> - * The followed transitions are SAP component state machine transitions
> - * which are described in 802.2 LLC protocol standard document.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - *		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/types.h>
> -#include <net/llc_if.h>
> -#include <net/llc_s_ev.h>
> -#include <net/llc_s_ac.h>
> -#include <net/llc_s_st.h>
> -
> -/* dummy last-transition indicator; common to all state transition groups
> - * last entry for this state
> - * all members are zeros, .bss zeroes it
> - */
> -static const struct llc_sap_state_trans llc_sap_state_trans_end;
> -
> -/* state LLC_SAP_STATE_INACTIVE transition for
> - * LLC_SAP_EV_ACTIVATION_REQ event
> - */
> -static const llc_sap_action_t llc_sap_inactive_state_actions_1[] = {
> -	[0] = llc_sap_action_report_status,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_inactive_state_trans_1 = {
> -	.ev =		llc_sap_ev_activation_req,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_inactive_state_actions_1,
> -};
> -
> -/* array of pointers; one to each transition */
> -static const struct llc_sap_state_trans *llc_sap_inactive_state_transitions[] = {
> -	[0] = &llc_sap_inactive_state_trans_1,
> -	[1] = &llc_sap_state_trans_end,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_RX_UI event */
> -static const llc_sap_action_t llc_sap_active_state_actions_1[] = {
> -	[0] = llc_sap_action_unitdata_ind,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_1 = {
> -	.ev =		llc_sap_ev_rx_ui,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_1,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_UNITDATA_REQ event */
> -static const llc_sap_action_t llc_sap_active_state_actions_2[] = {
> -	[0] = llc_sap_action_send_ui,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_2 = {
> -	.ev =		llc_sap_ev_unitdata_req,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_2,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_XID_REQ event */
> -static const llc_sap_action_t llc_sap_active_state_actions_3[] = {
> -	[0] = llc_sap_action_send_xid_c,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_3 = {
> -	.ev =		llc_sap_ev_xid_req,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_3,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_RX_XID_C event */
> -static const llc_sap_action_t llc_sap_active_state_actions_4[] = {
> -	[0] = llc_sap_action_send_xid_r,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_4 = {
> -	.ev =		llc_sap_ev_rx_xid_c,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_4,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_RX_XID_R event */
> -static const llc_sap_action_t llc_sap_active_state_actions_5[] = {
> -	[0] = llc_sap_action_xid_ind,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_5 = {
> -	.ev =		llc_sap_ev_rx_xid_r,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_5,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_TEST_REQ event */
> -static const llc_sap_action_t llc_sap_active_state_actions_6[] = {
> -	[0] = llc_sap_action_send_test_c,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_6 = {
> -	.ev =		llc_sap_ev_test_req,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_6,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_RX_TEST_C event */
> -static const llc_sap_action_t llc_sap_active_state_actions_7[] = {
> -	[0] = llc_sap_action_send_test_r,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_7 = {
> -	.ev =		llc_sap_ev_rx_test_c,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_7
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for LLC_SAP_EV_RX_TEST_R event */
> -static const llc_sap_action_t llc_sap_active_state_actions_8[] = {
> -	[0] = llc_sap_action_test_ind,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_8 = {
> -	.ev =		llc_sap_ev_rx_test_r,
> -	.next_state =	LLC_SAP_STATE_ACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_8,
> -};
> -
> -/* state LLC_SAP_STATE_ACTIVE transition for
> - * LLC_SAP_EV_DEACTIVATION_REQ event
> - */
> -static const llc_sap_action_t llc_sap_active_state_actions_9[] = {
> -	[0] = llc_sap_action_report_status,
> -	[1] = NULL,
> -};
> -
> -static const struct llc_sap_state_trans llc_sap_active_state_trans_9 = {
> -	.ev =		llc_sap_ev_deactivation_req,
> -	.next_state =	LLC_SAP_STATE_INACTIVE,
> -	.ev_actions =	llc_sap_active_state_actions_9
> -};
> -
> -/* array of pointers; one to each transition */
> -static const struct llc_sap_state_trans *llc_sap_active_state_transitions[] = {
> -	[0] = &llc_sap_active_state_trans_2,
> -	[1] = &llc_sap_active_state_trans_1,
> -	[2] = &llc_sap_active_state_trans_3,
> -	[3] = &llc_sap_active_state_trans_4,
> -	[4] = &llc_sap_active_state_trans_5,
> -	[5] = &llc_sap_active_state_trans_6,
> -	[6] = &llc_sap_active_state_trans_7,
> -	[7] = &llc_sap_active_state_trans_8,
> -	[8] = &llc_sap_active_state_trans_9,
> -	[9] = &llc_sap_state_trans_end,
> -};
> -
> -/* SAP state transition table */
> -struct llc_sap_state llc_sap_state_table[LLC_NR_SAP_STATES] = {
> -	[LLC_SAP_STATE_INACTIVE - 1] = {
> -		.curr_state	= LLC_SAP_STATE_INACTIVE,
> -		.transitions	= llc_sap_inactive_state_transitions,
> -	},
> -	[LLC_SAP_STATE_ACTIVE - 1] = {
> -		.curr_state	= LLC_SAP_STATE_ACTIVE,
> -		.transitions	= llc_sap_active_state_transitions,
> -	},
> -};
> diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
> deleted file mode 100644
> index 3904a1b4ba84..000000000000
> --- a/net/llc/llc_sap.c
> +++ /dev/null
> @@ -1,437 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_sap.c - driver routines for SAP component.
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <net/llc.h>
> -#include <net/llc_if.h>
> -#include <net/llc_conn.h>
> -#include <net/llc_pdu.h>
> -#include <net/llc_sap.h>
> -#include <net/llc_s_ac.h>
> -#include <net/llc_s_ev.h>
> -#include <net/llc_s_st.h>
> -#include <net/sock.h>
> -#include <net/tcp_states.h>
> -#include <linux/llc.h>
> -#include <linux/slab.h>
> -
> -static int llc_mac_header_len(struct net_device *dev)
> -{
> -	switch (dev->type) {
> -	case ARPHRD_ETHER:
> -	case ARPHRD_LOOPBACK:
> -		return LL_RESERVED_SPACE(dev);
> -	}
> -	return 0;
> -}
> -
> -/**
> - *	llc_alloc_frame - allocates sk_buff for frame
> - *	@sk:  socket to allocate frame to
> - *	@dev: network device this skb will be sent over
> - *	@type: pdu type to allocate
> - *	@data_size: data size to allocate
> - *
> - *	Allocates an sk_buff for frame and initializes sk_buff fields.
> - *	Returns allocated skb or %NULL when out of memory.
> - */
> -struct sk_buff *llc_alloc_frame(struct sock *sk, struct net_device *dev,
> -				u8 type, u32 data_size)
> -{
> -	int hlen = type == LLC_PDU_TYPE_U ? 3 : 4;
> -	struct sk_buff *skb;
> -
> -	hlen += llc_mac_header_len(dev);
> -	skb = alloc_skb(hlen + data_size, GFP_ATOMIC);
> -
> -	if (skb) {
> -		skb_reset_mac_header(skb);
> -		skb_reserve(skb, hlen);
> -		skb_reset_network_header(skb);
> -		skb_reset_transport_header(skb);
> -		skb->protocol = htons(ETH_P_802_2);
> -		skb->dev      = dev;
> -		if (sk != NULL)
> -			skb_set_owner_w(skb, sk);
> -	}
> -	return skb;
> -}
> -
> -void llc_save_primitive(struct sock *sk, struct sk_buff *skb, u8 prim)
> -{
> -	struct sockaddr_llc *addr;
> -
> -       /* save primitive for use by the user. */
> -	addr		  = llc_ui_skb_cb(skb);
> -
> -	memset(addr, 0, sizeof(*addr));
> -	addr->sllc_family = sk->sk_family;
> -	addr->sllc_arphrd = skb->dev->type;
> -	addr->sllc_test   = prim == LLC_TEST_PRIM;
> -	addr->sllc_xid    = prim == LLC_XID_PRIM;
> -	addr->sllc_ua     = prim == LLC_DATAUNIT_PRIM;
> -	llc_pdu_decode_sa(skb, addr->sllc_mac);
> -	llc_pdu_decode_ssap(skb, &addr->sllc_sap);
> -}
> -
> -/**
> - *	llc_sap_rtn_pdu - Informs upper layer on rx of an UI, XID or TEST pdu.
> - *	@sap: pointer to SAP
> - *	@skb: received pdu
> - */
> -void llc_sap_rtn_pdu(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	switch (LLC_U_PDU_RSP(pdu)) {
> -	case LLC_1_PDU_CMD_TEST:
> -		ev->prim = LLC_TEST_PRIM;	break;
> -	case LLC_1_PDU_CMD_XID:
> -		ev->prim = LLC_XID_PRIM;	break;
> -	case LLC_1_PDU_CMD_UI:
> -		ev->prim = LLC_DATAUNIT_PRIM;	break;
> -	}
> -	ev->ind_cfm_flag = LLC_IND;
> -}
> -
> -/**
> - *	llc_find_sap_trans - finds transition for event
> - *	@sap: pointer to SAP
> - *	@skb: happened event
> - *
> - *	This function finds transition that matches with happened event.
> - *	Returns the pointer to found transition on success or %NULL for
> - *	failure.
> - */
> -static const struct llc_sap_state_trans *llc_find_sap_trans(struct llc_sap *sap,
> -							    struct sk_buff *skb)
> -{
> -	int i = 0;
> -	const struct llc_sap_state_trans *rc = NULL;
> -	const struct llc_sap_state_trans **next_trans;
> -	struct llc_sap_state *curr_state = &llc_sap_state_table[sap->state - 1];
> -	/*
> -	 * Search thru events for this state until list exhausted or until
> -	 * its obvious the event is not valid for the current state
> -	 */
> -	for (next_trans = curr_state->transitions; next_trans[i]->ev; i++)
> -		if (!next_trans[i]->ev(sap, skb)) {
> -			rc = next_trans[i]; /* got event match; return it */
> -			break;
> -		}
> -	return rc;
> -}
> -
> -/**
> - *	llc_exec_sap_trans_actions - execute actions related to event
> - *	@sap: pointer to SAP
> - *	@trans: pointer to transition that it's actions must be performed
> - *	@skb: happened event.
> - *
> - *	This function executes actions that is related to happened event.
> - *	Returns 0 for success and 1 for failure of at least one action.
> - */
> -static int llc_exec_sap_trans_actions(struct llc_sap *sap,
> -				      const struct llc_sap_state_trans *trans,
> -				      struct sk_buff *skb)
> -{
> -	int rc = 0;
> -	const llc_sap_action_t *next_action = trans->ev_actions;
> -
> -	for (; next_action && *next_action; next_action++)
> -		if ((*next_action)(sap, skb))
> -			rc = 1;
> -	return rc;
> -}
> -
> -/**
> - *	llc_sap_next_state - finds transition, execs actions & change SAP state
> - *	@sap: pointer to SAP
> - *	@skb: happened event
> - *
> - *	This function finds transition that matches with happened event, then
> - *	executes related actions and finally changes state of SAP. It returns
> - *	0 on success and 1 for failure.
> - */
> -static int llc_sap_next_state(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	const struct llc_sap_state_trans *trans;
> -	int rc = 1;
> -
> -	if (sap->state > LLC_NR_SAP_STATES)
> -		goto out;
> -	trans = llc_find_sap_trans(sap, skb);
> -	if (!trans)
> -		goto out;
> -	/*
> -	 * Got the state to which we next transition; perform the actions
> -	 * associated with this transition before actually transitioning to the
> -	 * next state
> -	 */
> -	rc = llc_exec_sap_trans_actions(sap, trans, skb);
> -	if (rc)
> -		goto out;
> -	/*
> -	 * Transition SAP to next state if all actions execute successfully
> -	 */
> -	sap->state = trans->next_state;
> -out:
> -	return rc;
> -}
> -
> -/**
> - *	llc_sap_state_process - sends event to SAP state machine
> - *	@sap: sap to use
> - *	@skb: pointer to occurred event
> - *
> - *	After executing actions of the event, upper layer will be indicated
> - *	if needed(on receiving an UI frame). sk can be null for the
> - *	datalink_proto case.
> - *
> - *	This function always consumes a reference to the skb.
> - */
> -static void llc_sap_state_process(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	ev->ind_cfm_flag = 0;
> -	llc_sap_next_state(sap, skb);
> -
> -	if (ev->ind_cfm_flag == LLC_IND && skb->sk->sk_state != TCP_LISTEN) {
> -		llc_save_primitive(skb->sk, skb, ev->prim);
> -
> -		/* queue skb to the user. */
> -		if (sock_queue_rcv_skb(skb->sk, skb) == 0)
> -			return;
> -	}
> -	kfree_skb(skb);
> -}
> -
> -/**
> - *	llc_build_and_send_test_pkt - TEST interface for upper layers.
> - *	@sap: sap to use
> - *	@skb: packet to send
> - *	@dmac: destination mac address
> - *	@dsap: destination sap
> - *
> - *	This function is called when upper layer wants to send a TEST pdu.
> - *	Returns 0 for success, 1 otherwise.
> - */
> -void llc_build_and_send_test_pkt(struct llc_sap *sap,
> -				 struct sk_buff *skb, u8 *dmac, u8 dsap)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	ev->saddr.lsap = sap->laddr.lsap;
> -	ev->daddr.lsap = dsap;
> -	memcpy(ev->saddr.mac, skb->dev->dev_addr, IFHWADDRLEN);
> -	memcpy(ev->daddr.mac, dmac, IFHWADDRLEN);
> -
> -	ev->type      = LLC_SAP_EV_TYPE_PRIM;
> -	ev->prim      = LLC_TEST_PRIM;
> -	ev->prim_type = LLC_PRIM_TYPE_REQ;
> -	llc_sap_state_process(sap, skb);
> -}
> -
> -/**
> - *	llc_build_and_send_xid_pkt - XID interface for upper layers
> - *	@sap: sap to use
> - *	@skb: packet to send
> - *	@dmac: destination mac address
> - *	@dsap: destination sap
> - *
> - *	This function is called when upper layer wants to send a XID pdu.
> - *	Returns 0 for success, 1 otherwise.
> - */
> -void llc_build_and_send_xid_pkt(struct llc_sap *sap, struct sk_buff *skb,
> -				u8 *dmac, u8 dsap)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	ev->saddr.lsap = sap->laddr.lsap;
> -	ev->daddr.lsap = dsap;
> -	memcpy(ev->saddr.mac, skb->dev->dev_addr, IFHWADDRLEN);
> -	memcpy(ev->daddr.mac, dmac, IFHWADDRLEN);
> -
> -	ev->type      = LLC_SAP_EV_TYPE_PRIM;
> -	ev->prim      = LLC_XID_PRIM;
> -	ev->prim_type = LLC_PRIM_TYPE_REQ;
> -	llc_sap_state_process(sap, skb);
> -}
> -
> -/**
> - *	llc_sap_rcv - sends received pdus to the sap state machine
> - *	@sap: current sap component structure.
> - *	@skb: received frame.
> - *	@sk:  socket to associate to frame
> - *
> - *	Sends received pdus to the sap state machine.
> - */
> -static void llc_sap_rcv(struct llc_sap *sap, struct sk_buff *skb,
> -			struct sock *sk)
> -{
> -	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
> -
> -	ev->type   = LLC_SAP_EV_TYPE_PDU;
> -	ev->reason = 0;
> -	skb_orphan(skb);
> -	sock_hold(sk);
> -	skb->sk = sk;
> -	skb->destructor = sock_efree;
> -	llc_sap_state_process(sap, skb);
> -}
> -
> -static inline bool llc_dgram_match(const struct llc_sap *sap,
> -				   const struct llc_addr *laddr,
> -				   const struct sock *sk,
> -				   const struct net *net)
> -{
> -     struct llc_sock *llc = llc_sk(sk);
> -
> -     return sk->sk_type == SOCK_DGRAM &&
> -	     net_eq(sock_net(sk), net) &&
> -	     llc->laddr.lsap == laddr->lsap &&
> -	     ether_addr_equal(llc->laddr.mac, laddr->mac);
> -}
> -
> -/**
> - *	llc_lookup_dgram - Finds dgram socket for the local sap/mac
> - *	@sap: SAP
> - *	@laddr: address of local LLC (MAC + SAP)
> - *	@net: netns to look up a socket in
> - *
> - *	Search socket list of the SAP and finds connection using the local
> - *	mac, and local sap. Returns pointer for socket found, %NULL otherwise.
> - */
> -static struct sock *llc_lookup_dgram(struct llc_sap *sap,
> -				     const struct llc_addr *laddr,
> -				     const struct net *net)
> -{
> -	struct sock *rc;
> -	struct hlist_nulls_node *node;
> -	int slot = llc_sk_laddr_hashfn(sap, laddr);
> -	struct hlist_nulls_head *laddr_hb = &sap->sk_laddr_hash[slot];
> -
> -	rcu_read_lock_bh();
> -again:
> -	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
> -		if (llc_dgram_match(sap, laddr, rc, net)) {
> -			/* Extra checks required by SLAB_TYPESAFE_BY_RCU */
> -			if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
> -				goto again;
> -			if (unlikely(llc_sk(rc)->sap != sap ||
> -				     !llc_dgram_match(sap, laddr, rc, net))) {
> -				sock_put(rc);
> -				continue;
> -			}
> -			goto found;
> -		}
> -	}
> -	rc = NULL;
> -	/*
> -	 * if the nulls value we got at the end of this lookup is
> -	 * not the expected one, we must restart lookup.
> -	 * We probably met an item that was moved to another chain.
> -	 */
> -	if (unlikely(get_nulls_value(node) != slot))
> -		goto again;
> -found:
> -	rcu_read_unlock_bh();
> -	return rc;
> -}
> -
> -static inline bool llc_mcast_match(const struct llc_sap *sap,
> -				   const struct llc_addr *laddr,
> -				   const struct sk_buff *skb,
> -				   const struct sock *sk)
> -{
> -     struct llc_sock *llc = llc_sk(sk);
> -
> -     return sk->sk_type == SOCK_DGRAM &&
> -	  llc->laddr.lsap == laddr->lsap &&
> -	  llc->dev == skb->dev;
> -}
> -
> -static void llc_do_mcast(struct llc_sap *sap, struct sk_buff *skb,
> -			 struct sock **stack, int count)
> -{
> -	struct sk_buff *skb1;
> -	int i;
> -
> -	for (i = 0; i < count; i++) {
> -		skb1 = skb_clone(skb, GFP_ATOMIC);
> -		if (!skb1) {
> -			sock_put(stack[i]);
> -			continue;
> -		}
> -
> -		llc_sap_rcv(sap, skb1, stack[i]);
> -		sock_put(stack[i]);
> -	}
> -}
> -
> -/**
> - * 	llc_sap_mcast - Deliver multicast PDU's to all matching datagram sockets.
> - *	@sap: SAP
> - *	@laddr: address of local LLC (MAC + SAP)
> - *	@skb: PDU to deliver
> - *
> - *	Search socket list of the SAP and finds connections with same sap.
> - *	Deliver clone to each.
> - */
> -static void llc_sap_mcast(struct llc_sap *sap,
> -			  const struct llc_addr *laddr,
> -			  struct sk_buff *skb)
> -{
> -	int i = 0;
> -	struct sock *sk;
> -	struct sock *stack[256 / sizeof(struct sock *)];
> -	struct llc_sock *llc;
> -	struct hlist_head *dev_hb = llc_sk_dev_hash(sap, skb->dev->ifindex);
> -
> -	spin_lock_bh(&sap->sk_lock);
> -	hlist_for_each_entry(llc, dev_hb, dev_hash_node) {
> -
> -		sk = &llc->sk;
> -
> -		if (!llc_mcast_match(sap, laddr, skb, sk))
> -			continue;
> -
> -		sock_hold(sk);
> -		if (i < ARRAY_SIZE(stack))
> -			stack[i++] = sk;
> -		else {
> -			llc_do_mcast(sap, skb, stack, i);
> -			i = 0;
> -		}
> -	}
> -	spin_unlock_bh(&sap->sk_lock);
> -
> -	llc_do_mcast(sap, skb, stack, i);
> -}
> -
> -
> -void llc_sap_handler(struct llc_sap *sap, struct sk_buff *skb)
> -{
> -	struct llc_addr laddr;
> -
> -	llc_pdu_decode_da(skb, laddr.mac);
> -	llc_pdu_decode_dsap(skb, &laddr.lsap);
> -
> -	if (is_multicast_ether_addr(laddr.mac)) {
> -		llc_sap_mcast(sap, &laddr, skb);
> -		kfree_skb(skb);
> -	} else {
> -		struct sock *sk = llc_lookup_dgram(sap, &laddr, dev_net(skb->dev));
> -		if (sk) {
> -			llc_sap_rcv(sap, skb, sk);
> -			sock_put(sk);
> -		} else
> -			kfree_skb(skb);
> -	}
> -}
> diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
> deleted file mode 100644
> index 77fd0ac75263..000000000000
> --- a/net/llc/llc_station.c
> +++ /dev/null
> @@ -1,120 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * llc_station.c - station component of LLC
> - *
> - * Copyright (c) 1997 by Procom Technology, Inc.
> - * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/slab.h>
> -#include <net/llc.h>
> -#include <net/llc_sap.h>
> -#include <net/llc_conn.h>
> -#include <net/llc_c_ac.h>
> -#include <net/llc_s_ac.h>
> -#include <net/llc_c_ev.h>
> -#include <net/llc_c_st.h>
> -#include <net/llc_s_ev.h>
> -#include <net/llc_s_st.h>
> -#include <net/llc_pdu.h>
> -
> -static int llc_stat_ev_rx_null_dsap_xid_c(struct sk_buff *skb)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
> -	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
> -	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID &&
> -	       !pdu->dsap;				/* NULL DSAP value */
> -}
> -
> -static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
> -{
> -	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
> -
> -	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
> -	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
> -	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_TEST &&
> -	       !pdu->dsap;				/* NULL DSAP */
> -}
> -
> -static int llc_station_ac_send_xid_r(struct sk_buff *skb)
> -{
> -	u8 mac_da[ETH_ALEN], dsap;
> -	int rc = 1;
> -	struct sk_buff *nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U,
> -					       sizeof(struct llc_xid_info));
> -
> -	if (!nskb)
> -		goto out;
> -	llc_pdu_decode_sa(skb, mac_da);
> -	llc_pdu_decode_ssap(skb, &dsap);
> -	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, 0, dsap, LLC_PDU_RSP);
> -	llc_pdu_init_as_xid_rsp(nskb, LLC_XID_NULL_CLASS_2, 127);
> -	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, mac_da);
> -	if (unlikely(rc))
> -		goto free;
> -	dev_queue_xmit(nskb);
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -static int llc_station_ac_send_test_r(struct sk_buff *skb)
> -{
> -	u8 mac_da[ETH_ALEN], dsap;
> -	int rc = 1;
> -	u32 data_size;
> -	struct sk_buff *nskb;
> -
> -	if (skb->mac_len < ETH_HLEN)
> -		goto out;
> -
> -	/* The test request command is type U (llc_len = 3) */
> -	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
> -	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
> -
> -	if (!nskb)
> -		goto out;
> -	llc_pdu_decode_sa(skb, mac_da);
> -	llc_pdu_decode_ssap(skb, &dsap);
> -	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, 0, dsap, LLC_PDU_RSP);
> -	llc_pdu_init_as_test_rsp(nskb, skb);
> -	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, mac_da);
> -	if (unlikely(rc))
> -		goto free;
> -	dev_queue_xmit(nskb);
> -out:
> -	return rc;
> -free:
> -	kfree_skb(nskb);
> -	goto out;
> -}
> -
> -/**
> - *	llc_station_rcv - send received pdu to the station state machine
> - *	@skb: received frame.
> - *
> - *	Sends data unit to station state machine.
> - */
> -static void llc_station_rcv(struct sk_buff *skb)
> -{
> -	if (llc_stat_ev_rx_null_dsap_xid_c(skb))
> -		llc_station_ac_send_xid_r(skb);
> -	else if (llc_stat_ev_rx_null_dsap_test_c(skb))
> -		llc_station_ac_send_test_r(skb);
> -	kfree_skb(skb);
> -}
> -
> -void __init llc_station_init(void)
> -{
> -	llc_set_station_handler(llc_station_rcv);
> -}
> -
> -void llc_station_exit(void)
> -{
> -	llc_set_station_handler(NULL);
> -}
> diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
> deleted file mode 100644
> index 15f1e5d88f20..000000000000
> --- a/net/llc/sysctl_net_llc.c
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * sysctl_net_llc.c: sysctl interface to LLC net subsystem.
> - *
> - * Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> - */
> -
> -#include <linux/mm.h>
> -#include <linux/init.h>
> -#include <linux/sysctl.h>
> -#include <net/net_namespace.h>
> -#include <net/llc.h>
> -
> -static struct ctl_table llc2_timeout_table[] = {
> -	{
> -		.procname	= "ack",
> -		.data		= &sysctl_llc2_ack_timeout,
> -		.maxlen		= sizeof(sysctl_llc2_ack_timeout),
> -		.mode		= 0644,
> -		.proc_handler   = proc_dointvec_jiffies,
> -	},
> -	{
> -		.procname	= "busy",
> -		.data		= &sysctl_llc2_busy_timeout,
> -		.maxlen		= sizeof(sysctl_llc2_busy_timeout),
> -		.mode		= 0644,
> -		.proc_handler   = proc_dointvec_jiffies,
> -	},
> -	{
> -		.procname	= "p",
> -		.data		= &sysctl_llc2_p_timeout,
> -		.maxlen		= sizeof(sysctl_llc2_p_timeout),
> -		.mode		= 0644,
> -		.proc_handler   = proc_dointvec_jiffies,
> -	},
> -	{
> -		.procname	= "rej",
> -		.data		= &sysctl_llc2_rej_timeout,
> -		.maxlen		= sizeof(sysctl_llc2_rej_timeout),
> -		.mode		= 0644,
> -		.proc_handler   = proc_dointvec_jiffies,
> -	},
> -};
> -
> -static struct ctl_table_header *llc2_timeout_header;
> -static struct ctl_table_header *llc_station_header;
> -
> -int __init llc_sysctl_init(void)
> -{
> -	static struct ctl_table empty[1] = {};
> -	llc2_timeout_header = register_net_sysctl(&init_net, "net/llc/llc2/timeout", llc2_timeout_table);
> -	llc_station_header = register_net_sysctl_sz(&init_net, "net/llc/station", empty, 0);
> -
> -	if (!llc2_timeout_header || !llc_station_header) {
> -		llc_sysctl_exit();
> -		return -ENOMEM;
> -	}
> -	return 0;
> -}
> -
> -void llc_sysctl_exit(void)
> -{
> -	if (llc2_timeout_header) {
> -		unregister_net_sysctl_table(llc2_timeout_header);
> -		llc2_timeout_header = NULL;
> -	}
> -	if (llc_station_header) {
> -		unregister_net_sysctl_table(llc_station_header);
> -		llc_station_header = NULL;
> -	}
> -}
> diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
> index e76ea9b62974..dbef879935f3 100644
> --- a/arch/loongarch/configs/loongson32_defconfig
> +++ b/arch/loongarch/configs/loongson32_defconfig
> @@ -321,7 +321,6 @@ CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
>  CONFIG_VLAN_8021Q_GVRP=y
>  CONFIG_VLAN_8021Q_MVRP=y
> -CONFIG_LLC2=m
>  CONFIG_NET_SCHED=y
>  CONFIG_NET_SCH_HTB=m
>  CONFIG_NET_SCH_PRIO=m
> diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
> index 976340d4d514..4f8bb77b8a1e 100644
> --- a/arch/loongarch/configs/loongson64_defconfig
> +++ b/arch/loongarch/configs/loongson64_defconfig
> @@ -337,7 +337,6 @@ CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
>  CONFIG_VLAN_8021Q_GVRP=y
>  CONFIG_VLAN_8021Q_MVRP=y
> -CONFIG_LLC2=m
>  CONFIG_NET_SCHED=y
>  CONFIG_NET_SCH_HTB=m
>  CONFIG_NET_SCH_PRIO=m
> diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
> index 7834569a8314..718a04dbe88d 100644
> --- a/arch/mips/configs/gpr_defconfig
> +++ b/arch/mips/configs/gpr_defconfig
> @@ -90,7 +90,6 @@ CONFIG_ATM=y
>  CONFIG_ATM_BR2684=m
>  CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
> -CONFIG_LLC2=m
>  CONFIG_DEV_APPLETALK=m
>  CONFIG_IPDDP=m
>  CONFIG_IPDDP_ENCAP=y
> diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
> index e28a0b1e6d52..095176c3dbee 100644
> --- a/arch/mips/configs/mtx1_defconfig
> +++ b/arch/mips/configs/mtx1_defconfig
> @@ -135,7 +135,6 @@ CONFIG_ATM=y
>  CONFIG_ATM_BR2684=m
>  CONFIG_BRIDGE=m
>  CONFIG_VLAN_8021Q=m
> -CONFIG_LLC2=m
>  CONFIG_DEV_APPLETALK=m
>  CONFIG_IPDDP=m
>  CONFIG_IPDDP_ENCAP=y
> diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
> index a88322fe3935..e2f7d01f4d10 100644
> --- a/arch/mips/configs/rb532_defconfig
> +++ b/arch/mips/configs/rb532_defconfig
> @@ -70,7 +70,6 @@ CONFIG_IP_NF_MANGLE=y
>  CONFIG_IP_NF_RAW=m
>  CONFIG_BRIDGE=y
>  CONFIG_VLAN_8021Q=y
> -CONFIG_LLC2=m
>  CONFIG_NET_SCHED=y
>  CONFIG_NET_SCH_CBQ=m
>  CONFIG_NET_SCH_PRIO=m
> diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
> index 3572a32f7849..3550250e8b87 100644
> --- a/arch/parisc/configs/generic-32bit_defconfig
> +++ b/arch/parisc/configs/generic-32bit_defconfig
> @@ -35,7 +35,6 @@ CONFIG_INET=y
>  CONFIG_INET_AH=m
>  CONFIG_INET_ESP=m
>  CONFIG_INET_DIAG=m
> -CONFIG_LLC2=m
>  # CONFIG_WIRELESS is not set
>  CONFIG_EISA=y
>  CONFIG_PCI=y

