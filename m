Received: from bg-bfd.cloudflare-smtp.org (bg-bfd.cloudflare-smtp.org [104.30.16.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E23FFFA1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902150; cv=none; b=HRv9uznQTfHQbv0X1tJsauOEs+nFWz8rzF9manq6kp4ylK3J+GPHb+GtoVDLan5gXgoybXYCPcCr5cWAPi7dau12mDJ+nW+j7is563JFiMEA1g88+NPVXbSDL2zAfwEKpj0NJrrc1I1jfY6ruQuKydWX3KzP4M1nAZzjXqGWOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902150; c=relaxed/simple;
	bh=kq0Tcudey/zE28+R1y1husDF2nWbzjD6VOYTTBXQvk4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=hwPAcTWQf0LCOli5JwtpKOEWXmfu4KRW2UDJXbVUJVMrM5ProtWVRpDkJ/t/RtK/qh0iaTuXT/SmxsNEFveLHWPgjvbKLG0JHqOqutkF4DU8MNB377sUhVZ4jOQAvw851UNeR3uxzg5vc0AtqTDXA07tM5uJhcfxgRb2Huf1R7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vineyardtechnologies.org; spf=pass smtp.mailfrom=cf-bounce.vineyardtechnologies.org; dkim=pass (2048-bit key) header.d=vineyardtechnologies.org header.i=@vineyardtechnologies.org header.b=IgUzIrSH; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=Xgjj958h; arc=none smtp.client-ip=104.30.16.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vineyardtechnologies.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.vineyardtechnologies.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vineyardtechnologies.org header.i=@vineyardtechnologies.org header.b="IgUzIrSH";
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="Xgjj958h"
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=vineyardtechnologies.org; c=relaxed/relaxed;
	h=Date:Subject:Cc:To:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1791902148; x=1792506948; bh=GGSVkVgIJ9dMpNYUV8
	osYDtKxX1kfbWJI+yAw6Axw2c=; b=IgUzIrSHHHjBEnxcZW1iL6F3+68KOF1dB4E2jtjSmO2xj
	eSmwfWhLC9KZtXIoPDOGlX0mvbZzB+oPil6EeP23uL1QU9TATrXJEisUOtk5cpCLGVeoF00SO4v
	YuttZQgvzu8jYht3pSmkQIJo8JyyQg/A83V89Aa7X/NfEWcZTOyATk9ghFrCoUDp7zwfyQwLbZI
	Mh4JMP/Y0b/vkM6lHMuqgqWh7ab2r3/sBTxgYxkEog4BYZDaX+fx6l8tOkeKTYaauIwi2VYNsx4
	Mm2IZegdwEjQKU/a2icPHN28/JGcmkpgzDMwVEthnRG641IpHc4jfdk3SEhrzf+nzhsTIhBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=Date:Subject:Cc:To:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1791902148; x=1792506948; bh=GGSVkVgIJ9dMpNYUV8
	osYDtKxX1kfbWJI+yAw6Axw2c=; b=Xgjj958hte3NFf+BwusuEDrRS288DUDVm6n7/ROlU38q+
	gVL22HFX5DDirPOvK1LcM56khQ06QTUmwG/cxDUmLvS3dLu6wRXq2WawRJtUPtciY6xCw9qc0VZ
	W9bvqzG9bolKMgI5cexTAvp3PTVLOByxF+iiKb5fWePKqJSv+tdAwyASMc2L+pAPKiVQZ6PaiPU
	3M1q8oqjDBvjNNQu3E7xKsHiqVvZLu+PL3ZnRNVdpEG5Botgh3UQlKZCsvTUoHKWcpqdCgpinh0
	mjoh/82Ql0jPtJdIMEVyxwcLjYLpNZnA3+BVGo2unaaZhzsZNyCYCI3OvjB1yZs3jmxloORQ==;
Feedback-ID: vineyardtechnologies.org:5:6:Cloudflare
Message-ID: <Dvrf8IhF3j09acNeO4Muc57tY7i1vJz5ckdk@vineyardtechnologies.org>
Received: from authenticated-submission.invalid
        by mx.cloudflare.net (Cloudflare Email Submission) with ESMTPSA id 72lDyBGtB8bK; Tue, 13 Oct 2026 14:35:26 +0000
From: Andrew Rogers <andrew.rogers@vineyardtechnologies.org>
To: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [BUG] af_unix: SOCK_SEQPACKET recv() returns 0 while a message is still queued
Date: Tue, 13 Oct 2026 14:35:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

A blocking recv() on an AF_UNIX SOCK_SEQPACKET socket can return 0 (EOF)
while a message the peer sent before closing is still in the receive
queue. The message is then lost: it is freed with
SKB_DROP_REASON_SOCKET_CLOSE when the receiver closes its socket, along
with any file descriptors it carried in SCM_RIGHTS.

Where it shows up
-----------------

Chrome's Linux sandbox brokers open() for its GPU process. For each
request the client creates a SOCK_SEQPACKET socketpair, passes one end
to the broker process and blocks in recvmsg() on the other; the broker
replies with sendmsg(), passing the opened fd, and closes its end. With
the NVIDIA driver, which opens /dev/nvidiactl about 11 times per frame,
a WebGPU page makes around 8,000 of these round trips a second, and
within minutes one recvmsg() returns 0 although the broker's sendmsg()
succeeded. The open() fails and the GPU process loses its device or
crashes. A trace of one failure, with t the moment Chrome's broker
client gives up:

  t-42.8us  broker  openat("/dev/nvidiactl") = 57
  t-40.6us  broker  sendmsg(reply socket, 8 bytes + SCM_RIGHTS fd 57) = 8
  t-38.7us  broker  close(reply socket)        -> unix_release_sock()
  t-11.7us  gpu     recvmsg(other end) = 0
  t-4us     gpu     close(other end): kfree_skb reason=SOCKET_CLOSE
                    in unix_release_sock(), the unread reply

Reproducer
----------

seqpacket-eof.c is below. Each pair of threads repeats: the receiver
makes a socketpair, hands one end to the sender and blocks in recv();
the sender send()s 8 bytes and close()s. When recv() returns 0, the
receiver retries with MSG_DONTWAIT and counts a loss if the message is
there. An optional SCHED_FIFO thread on each receiver's CPU wakes from a
timer about every 20us and spins for 3us, which preempts the receiver
at arbitrary points and makes the race much more frequent. Without it
the machine's own interrupts are enough, just rarely.

Results on Ubuntu 7.0.0-38-generic (7.0.14), x86_64, 8 CPUs,
PREEMPT_DYNAMIC (lazy), HZ=1000, 2 pairs, otherwise idle desktop:

  SOCK_SEQPACKET, SCHED_FIFO interrupter (root)   30 s   7.7M rounds  61 lost
  SOCK_SEQPACKET, interrupter as SCHED_OTHER     120 s  36.6M rounds   4 lost
  SOCK_SEQPACKET, no interrupter, unprivileged   120 s  38.9M rounds   3 lost
  SOCK_STREAM,    SCHED_FIFO interrupter (root)   30 s   7.6M rounds   0 lost

No kprobes or other tracing were attached during these runs.

Analysis
--------

unix_seqpacket_recvmsg() goes through __unix_dgram_recvmsg(), which
waits in __skb_wait_for_more_packets(). That function tests the queue
and the shutdown state with two separate, unlocked reads:

	if (READ_ONCE(queue->prev) != skb)
		goto out;

	/* Socket shut down? */
	if (sk->sk_shutdown & RCV_SHUTDOWN)
		goto out_noerr;

On the other side, unix_dgram_sendmsg() queues the skb under
unix_state_lock(other), and the close() that follows sets the peer's
sk_shutdown in unix_release_sock(), also under unix_state_lock(). If the
receiver reads queue->prev before the skb is queued and sk_shutdown
after the close, it returns 0 with the skb in its queue. That needs the
receiver to be held up between the two reads for about as long as the
sender takes from queueing to close, around a microsecond here, which
an interrupt or a preemption provides. To confirm the window, a kprobe
on the sk_shutdown test (__skb_wait_for_more_packets+0xcc in this
build) that busy-waits 3us made 6.8M of 6.9M rounds lose the message.

SOCK_STREAM is not affected: unix_stream_read_generic() and
unix_stream_data_wait() look at the queue and at RCV_SHUTDOWN under
unix_state_lock(), the lock the sender queues under.

The code in question is unchanged in v7.3-rc7. I have only tested the
Ubuntu 7.0 kernel above.

A fix could re-check the receive queue under unix_state_lock() before
__unix_dgram_recvmsg() reports EOF on a SEQPACKET socket, or have
__skb_wait_for_more_packets() look at the queue again after it sees
RCV_SHUTDOWN.

Thanks,
Andrew Rogers

----------------------------- seqpacket-eof.c -----------------------------
// SPDX-License-Identifier: GPL-2.0
// AF_UNIX SOCK_SEQPACKET: a blocking recv() can return 0 (EOF) while a
// message the peer sent before closing is still in the receive queue.
//
// Each pair of threads repeats: the receiver makes a socketpair, hands one
// end to the sender and blocks in recv() on the other; the sender send()s
// an 8-byte message and close()s its end. If recv() returns 0, the receiver
// retries with MSG_DONTWAIT; getting the message then shows EOF was
// reported while it was queued.
//
// The loss needs the receiver to be held up for about a microsecond inside
// __skb_wait_for_more_packets(), after it has seen the queue unchanged and
// before it tests sk_shutdown. Interrupts and preemption do that. An
// optional SCHED_FIFO thread on each receiver's CPU wakes from a timer
// about every PERIOD us and spins for SPIN us, preempting the receiver
// wherever it is, which makes the race much more frequent. Without root it
// runs as an ordinary thread; the race still happens, rarely.
//
//   cc -O2 -Wall -pthread -o seqpacket-eof seqpacket-eof.c
//   sudo ./seqpacket-eof [pairs [seconds [period_us spin_us [stream]]]]
//
// Defaults: 2 pairs, 30 s, period 20 us, spin 3 us. "0 0" disables the
// interrupter; "stream" uses SOCK_STREAM instead, for comparison. Needs two
// CPUs per pair. Exits 2 if any message was lost.
#define _GNU_SOURCE
#include <pthread.h>
#include <sched.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

struct pair {
    int recv_cpu, send_cpu;
    _Atomic int handoff;    // the sender's socket fd, or -1
    _Atomic int stop;
    unsigned long rounds, eof_with_data, eof_empty;
};

static int period_us = 20, spin_us = 3;
static int sock_type = SOCK_SEQPACKET;
static _Atomic int stop_all;

static void die(const char *what)
{
    perror(what);
    exit(1);
}

static void pin(int cpu)
{
    cpu_set_t set;

    CPU_ZERO(&set);
    CPU_SET(cpu, &set);
    pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
}

static uint64_t now_ns(void)
{
    struct timespec ts;

    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000u + ts.tv_nsec;
}

static void *sender(void *arg)
{
    struct pair *p = arg;
    const char msg[8] = "reply!!";

    pin(p->send_cpu);
    while (!atomic_load(&p->stop)) {
        int fd = atomic_exchange(&p->handoff, -1);

        if (fd < 0)
            continue;
        if (send(fd, msg, sizeof(msg), 0) != sizeof(msg))
            die("send");
        close(fd);
    }
    return NULL;
}

static void *receiver(void *arg)
{
    struct pair *p = arg;
    char buf[64];
    int sv[2];

    pin(p->recv_cpu);
    while (!atomic_load(&p->stop)) {
        ssize_t n;

        if (socketpair(AF_UNIX, sock_type, 0, sv) < 0)
            die("socketpair");
        atomic_store(&p->handoff, sv[1]);
        n = recv(sv[0], buf, sizeof(buf), 0);
        if (n == 0) {
            if (recv(sv[0], buf, sizeof(buf), MSG_DONTWAIT) > 0)
                p->eof_with_data++;
            else
                p->eof_empty++;
        } else if (n < 0) {
            die("recv");
        }
        close(sv[0]);
        p->rounds++;
    }
    return NULL;
}

static void *interrupter(void *arg)
{
    int cpu = (int)(intptr_t)arg;
    unsigned int seed = (unsigned int)cpu * 2654435761u;
    long period_ns = (long)period_us * 1000;

    pin(cpu);
    while (!atomic_load(&stop_all)) {
        // Jitter the period so the wakeups land at every point of the
        // receiver's path.
        struct timespec ts = {
            0, period_ns / 2 + rand_r(&seed) % (period_ns + 1)
        };
        uint64_t until;

        clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
        until = now_ns() + (uint64_t)spin_us * 1000;
        while (now_ns() < until)
            ;
    }
    return NULL;
}

static int start_interrupter(int cpu)
{
    struct sched_param sp = { .sched_priority = 1 };
    void *arg = (void *)(intptr_t)cpu;
    pthread_attr_t attr;
    pthread_t t;

    pthread_attr_init(&attr);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    pthread_attr_setschedparam(&attr, &sp);
    if (pthread_create(&t, &attr, interrupter, arg) == 0)
        return 1;
    pthread_create(&t, NULL, interrupter, arg);
    return 0;
}

int main(int argc, char **argv)
{
    int pairs = argc > 1 ? atoi(argv[1]) : 2;
    int seconds = argc > 2 ? atoi(argv[2]) : 30;
    int ncpu = (int)sysconf(_SC_NPROCESSORS_ONLN);
    unsigned long rounds = 0, bad = 0, empty = 0;
    struct pair *ps;
    int rt = 0;

    if (argc > 4) {
        period_us = atoi(argv[3]);
        spin_us = atoi(argv[4]);
    }
    if (argc > 5 && strcmp(argv[5], "stream") == 0)
        sock_type = SOCK_STREAM;
    if (pairs * 2 > ncpu) {
        fprintf(stderr, "need two CPUs per pair (%d online)\n", ncpu);
        return 1;
    }

    ps = calloc(pairs, sizeof(*ps));
    for (int i = 0; i < pairs; i++) {
        pthread_t t;

        ps[i].recv_cpu = 2 * i;
        ps[i].send_cpu = 2 * i + 1;
        atomic_store(&ps[i].handoff, -1);
        pthread_create(&t, NULL, sender, &ps[i]);
        pthread_create(&t, NULL, receiver, &ps[i]);
        if (period_us > 0)
            rt = start_interrupter(ps[i].recv_cpu);
    }

    printf("type=%s pairs=%d seconds=%d period=%dus spin=%dus "
           "interrupter=%s\n",
           sock_type == SOCK_STREAM ? "SOCK_STREAM" : "SOCK_SEQPACKET",
           pairs, seconds, period_us, spin_us,
           period_us <= 0 ? "none" :
           rt ? "SCHED_FIFO" : "SCHED_OTHER (SCHED_FIFO not permitted)");
    fflush(stdout);

    for (int s = 1; s <= seconds; s++) {
        sleep(1);
        rounds = bad = empty = 0;
        for (int i = 0; i < pairs; i++) {
            rounds += ps[i].rounds;
            bad += ps[i].eof_with_data;
            empty += ps[i].eof_empty;
        }
        if (s % 5 == 0 || s == seconds) {
            printf("t=%ds rounds=%lu eof_with_message_queued=%lu "
                   "eof_empty=%lu\n", s, rounds, bad, empty);
            fflush(stdout);
        }
    }
    atomic_store(&stop_all, 1);
    return bad ? 2 : 0;
}

